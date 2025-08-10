# Signature

A lightweight web page to capture a user's handwritten signature and download it as an image.

---

## ✨ Features

- Draw a signature with mouse or touch
- Clear/reset the canvas
- Download the signature as an image (PNG/JPG)
- Client‑side only (no backend required)

---

## 🧱 Tech Stack

- **Frontend:** HTML, CSS, JavaScript
- **Backend:** None (static site)

---

## 📁 Project Structure (top level)

```
└── Signature/
│   ├── Code_Book.fig
│   ├── Code_Book.m
│   ├── DATABASE.mat
│   ├── Recognition.fig
│   ├── Recognition.m
│   └── Untitled.m
```

---

## 🚀 Running Locally

### Option A: Open directly
Open `index.html` in your browser.

### Option B: Serve with a simple HTTP server
**Python 3**

```bash
python -m http.server 5500
# then visit http://localhost:5500/index.html
```

**Node**

```bash
npx serve .
# or
npx http-server -p 5500
```

---

## 🧩 How it Works (Canvas basics)

- Uses an HTML `<canvas>` element for drawing.
- Mouse/touch events track the pointer and draw on the canvas context.
- `canvas.toDataURL('image/png')` converts the drawing to an image for download.
- A **Clear** button resets the canvas.

---

## 🛠️ Customization Ideas

- Add color and line-width selectors
- Add Undo/Redo
- Export transparent PNG or PDF
- Save signature in `localStorage`
- Mobile-friendly toolbar

---

## 📝 License

Add your license of choice (e.g., MIT).
