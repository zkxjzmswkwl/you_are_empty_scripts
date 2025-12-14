from pathlib import Path

ROOT = Path(".")
EXTENSIONS = {".lua"}

def is_valid_utf8(data: bytes) -> bool:
    try:
        data.decode("utf-8")
        return True
    except UnicodeDecodeError:
        return False

def convert_file(path: Path):
    raw = path.read_bytes()

    if is_valid_utf8(raw):
        return False

    try:
        text = raw.decode("cp1251")
    except UnicodeDecodeError:
        print(f"[SKIP] {path} (not UTF-8, not CP-1251)")
        return False

    path.write_text(text, encoding="utf-8", newline="\n")
    return True

def main():
    modified = 0

    for path in ROOT.rglob("*"):
        try:
            if path.suffix.lower() in EXTENSIONS and path.is_file():
                if convert_file(path):
                    print(f"[FIXED] {path}")
                    modified += 1
        except:
            print("No perms prob.")

    print(f"\nDone. Converted {modified} file(s).")

if __name__ == "__main__":
    main()
