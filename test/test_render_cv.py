import copy
import importlib.util
from pathlib import Path
import unittest

import yaml
from rendercv.schema.models.cv.cv import Cv
from rendercv.schema.yaml_reader import read_yaml

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location("render_cv", ROOT / "bin/render_cv.py")
render_cv = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(render_cv)


class RenderCVInputTest(unittest.TestCase):
    def test_site_data_is_preserved_and_validates(self):
        source = yaml.safe_load((ROOT / "_data/cv.yml").read_text())["cv"]
        original = copy.deepcopy(source)
        result = render_cv.prepare_cv(source)
        serialized = yaml.safe_dump(result)
        self.assertNotRegex(serialized, r"[&*]id\d+")
        Cv.model_validate(read_yaml(serialized))
        self.assertEqual(source, original)
        self.assertEqual(result["headline"], source["label"])
        self.assertEqual(result["sections"]["Professional Summary"], [{"bullet": source["summary"]}])
        self.assertIn(source["address"]["street"], result["sections"]["Postal Address"][0]["bullet"])
        for title, entries in source["sections"].items():
            for original_entry, entry in zip(entries, result["sections"][title], strict=True):
                self.assertEqual({key: entry[key] for key in original_entry}, original_entry)
        publication = result["sections"]["Publications"][0]
        self.assertEqual(publication["pdf_title"], f"[{publication['title']}]({publication['url']})")
        self.assertEqual(publication["date"], str(publication["releaseDate"]))

    def test_native_rendercv_input_and_photo_are_supported(self):
        source = {"name": "Example", "headline": "Researcher", "sections": {"Profile": [{"bullet": "Example"}]}}
        self.assertEqual(render_cv.prepare_cv(source), source)
        self.assertEqual(render_cv.prepare_cv({**source, "image": "portrait.jpg"})["photo"], "portrait.jpg")


if __name__ == "__main__":
    unittest.main()
