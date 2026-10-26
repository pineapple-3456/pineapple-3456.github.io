"""Generate the PDF from the CV data used by the website."""

from pathlib import Path
import subprocess
import tempfile

import yaml


def prepare_cv(source):
    cv = dict(source)
    headline = cv.pop("label", None)
    if headline:
        cv["headline"] = headline
    photo = cv.pop("image", None)
    if photo:
        cv["photo"] = photo

    sections = {}
    summary = cv.pop("summary", None)
    if summary:
        sections["Professional Summary"] = [{"bullet": summary}]
    address = cv.pop("address", None)
    if address:
        sections["Postal Address"] = [{"bullet": ", ".join(str(value) for value in address.values() if value)}]
    cv["sections"] = {**sections, **cv.get("sections", {})}
    for title, entries in cv["sections"].items():
        cv["sections"][title] = []
        for entry in entries:
            if isinstance(entry, dict):
                entry = dict(entry)
                if "title" in entry:
                    entry["pdf_title"] = f"[{entry['title']}]({entry['url']})" if entry.get("url") else entry["title"]
                if "releaseDate" in entry:
                    entry["date"] = str(entry["releaseDate"])
            cv["sections"][title].append(entry)
    return cv


if __name__ == "__main__":
    root = Path(__file__).resolve().parent.parent
    data = yaml.safe_load((root / "_data/cv.yml").read_text())
    data["cv"] = prepare_cv(data["cv"])
    # Keep relative image and settings paths anchored to the original data directory.
    with tempfile.NamedTemporaryFile(mode="w", suffix=".yaml", prefix=".rendercv-", dir=root / "_data") as source:
        yaml.safe_dump(data, source, sort_keys=False, allow_unicode=True)
        source.flush()
        subprocess.run(
            [
                "rendercv", "render", source.name,
                "--settings", str(root / "assets/rendercv/settings.yaml"),
                "--design", str(root / "assets/rendercv/design.yaml"),
                "--locale-catalog", str(root / "assets/rendercv/locale.yaml"),
            ],
            cwd=root,
            check=True,
        )
