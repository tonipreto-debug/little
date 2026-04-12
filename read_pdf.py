import sys
import PyPDF2

try:
    with open("PORTAFOLIO EVENTOS.pdf", "rb") as file:
        reader = PyPDF2.PdfReader(file)
        text = ""
        for page in reader.pages:
            text += page.extract_text() + "\n"
        print(text[:10000]) # Print first 10000 chars for analysis
except Exception as e:
    print(f"Error reading PDF: {e}")
    try:
        import fitz
        doc = fitz.open("PORTAFOLIO EVENTOS.pdf")
        text = ""
        for page in doc:
            text += page.get_text() + "\n"
        print(text[:10000])
    except Exception as e2:
        print(f"Error reading with PyMuPDF: {e2}")
