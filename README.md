
# Offline Signature Verification (HMM-based)

Offline (scanned) **signature verification** system using **Hidden Markov Models (HMMs)**.  
The pipeline converts input signatures to **grayscale**, extracts **sequence features**, trains **per-user HMMs** from genuine samples, and **verifies** test signatures by likelihood scoring against the trained user model (and optional impostor/background models).

> Works on **static images** (PNG/JPG). No tablet/dynamic trajectory needed.

---

## ✨ What this repo does

- **Preprocessing**: grayscale → denoise → binarize → normalize size → (optional) skeletonize
- **Feature extraction (sequence)**: left-to-right scan windows with features per step (e.g., density, transitions, HOG, direction codes)
- **Modeling**: per-user **Gaussian HMM** (left-to-right topology) trained with Baum–Welch (EM)
- **Verification**: compute log-likelihood of a probe signature under the claimed user's HMM; accept if score ≥ threshold
- **Evaluation**: compute **FAR**, **FRR**, **EER**, ROC/DET; save per-user thresholds or a global threshold

---

## 🧱 Tech Stack

- **Python 3.9+**
- **OpenCV** for image ops
- **NumPy / SciPy**
- **hmmlearn** (or custom HMM if you prefer)
- **scikit-learn** (metrics/plots)

---

## 📁 Project Structure

```
signature-verification-hmm/
├── data/
│   ├── train/
│   │   ├── user_001/  # genuine signatures for training
│   │   │   ├── g1.png
│   │   │   ├── g2.png
│   │   │   └── ...
│   │   └── user_002/
│   ├── val/
│   │   ├── user_001/  # genuine + skilled for threshold tuning (optional)
│   │   └── user_002/
│   └── test/
│       ├── user_001/
│       │   ├── gen_*.png      # genuine
│       │   └── forg_*.png     # forgeries
│       └── user_002/
├── models/
│   └── user_001_hmm.joblib
├── src/
│   ├── preprocess.py
│   ├── features.py
│   ├── train.py
│   ├── verify.py
│   ├── evaluate.py
│   └── utils.py
├── requirements.txt
└── README.md
```

---

## 🔧 Installation

```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
# macOS/Linux
source .venv/bin/activate

pip install -r requirements.txt
```

**requirements.txt (suggested):**
```
opencv-python
numpy
scipy
scikit-learn
hmmlearn
matplotlib
joblib
```

---

## 🧭 End-to-end Pipeline

### 1) Preprocess (grayscale → binarize → normalize → (optional) skeletonize)
```python
# src/preprocess.py
import cv2, numpy as np

def preprocess(img_path, out_size=(128, 512), do_skel=False):
    img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
    img = cv2.GaussianBlur(img, (3,3), 0)
    _, bw = cv2.threshold(img, 0, 255, cv2.THRESH_BINARY_INV+cv2.THRESH_OTSU)
    # normalize canvas: crop to bounding box then resize
    ys, xs = np.where(bw>0)
    bw = bw[min(ys):max(ys)+1, min(xs):max(xs)+1] if len(xs) else bw
    bw = cv2.resize(bw, out_size, interpolation=cv2.INTER_AREA)
    if do_skel:
        bw = skeletonize(bw)  # implement Zhang–Suen or use skimage.morphology.skeletonize
    return bw
```

### 2) Sequence Feature Extraction (left-to-right sliding windows)
```python
# src/features.py
import numpy as np
import cv2

def extract_sequence_features(bw, win_w=8, step=4):
    H, W = bw.shape
    feats = []
    for x0 in range(0, W-win_w+1, step):
        patch = bw[:, x0:x0+win_w]
        # basic features: ink density and transitions per row
        density = patch.mean()/255.0
        transitions = np.mean([np.count_nonzero(np.diff(row>0)) for row in patch])
        # add HOG for local stroke orientation (coarse)
        hog = cv2.HOGDescriptor(_winSize=(win_w, H), _blockSize=(win_w, H),
                                _blockStride=(win_w, H), _cellSize=(win_w, H),
                                _nbins=9)
        h = hog.compute(patch).ravel() if H*win_w>=64 else np.zeros(9)
        feats.append(np.hstack([density, transitions, h]))
    X = np.vstack(feats).astype(np.float32) if feats else np.zeros((1,11), np.float32)
    return X  # shape: (T, D)  -> a sequence for HMM
```

### 3) Train per-user HMM
```python
# src/train.py
import glob, joblib, numpy as np
from hmmlearn.hmm import GaussianHMM
from preprocess import preprocess
from features import extract_sequence_features

def train_user(user_dir, n_states=6, cov_type='diag'):
    seqs = []
    for img_path in glob.glob(f"{user_dir}/*.png"):
        bw = preprocess(img_path)
        X = extract_sequence_features(bw)
        seqs.append(X)
    lengths = [len(x) for x in seqs]
    Xfull = np.vstack(seqs)
    hmm = GaussianHMM(n_components=n_states, covariance_type=cov_type, n_iter=200, tol=1e-3)
    hmm.fit(Xfull, lengths)
    return hmm
```

### 4) Verify a test signature
```python
# src/verify.py
import joblib, numpy as np
from preprocess import preprocess
from features import extract_sequence_features

def score(hmm, img_path):
    bw = preprocess(img_path)
    X = extract_sequence_features(bw)
    return hmm.score(X)  # log-likelihood

def decide(logL, threshold):
    return logL >= threshold
```

---

## 🚀 Usage (CLI examples)

### Train all users
```bash
python -m src.train --train_dir data/train --out_dir models --states 6
```
*(Implement argparse in `src/train.py` to loop users and save `joblib`)*

### Verify a probe
```bash
python -m src.verify --model models/user_001_hmm.joblib --img data/test/user_001/probe.png --threshold -1500
```

### Evaluate (FAR/FRR/EER)
```bash
python -m src.evaluate --test_dir data/test --models_dir models --out results/
```

---

## 🎯 Thresholding & Scoring

- **Global threshold**: one τ for all users (simpler, slightly worse EER)
- **User-specific threshold**: tune τᵤ on validation genuine vs forgery scores
- Optional **background/impostor model**: score = log p(X|user) − log p(X|bg)
- Report **FAR**, **FRR**, **EER** and plot ROC/DET

---

## 📊 Tips for Better Accuracy

- Normalize pen-thickness via skeletonization
- Try different window widths and strides
- Add direction codes, centroid shifts, contour curvature as features
- Tune HMM state count (4–10 typical), diagonal vs full covariance
- Score normalization (z-norm, t-norm) if impostor model available

---

## 🔐 Notes

- This is a **verification** (1:1) system with claimed identity
- Ensure **balanced** genuine/forgery sets for fair evaluation
- Keep data splits writer-disjoint across users to avoid leakage

---

## 📝 License

Add your preferred license (e.g., MIT).

---

## 🙌 Acknowledgements

- Inspired by classic HMM-based offline signature verification literature
- Built with OpenCV, hmmlearn, NumPy, and scikit-learn
