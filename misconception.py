import json
import re
import random
import tempfile

import pywikibot
import wikitextparser as wtp

PAGE = 'List_of_common_misconceptions'

with tempfile.TemporaryDirectory() as path:
    pywikibot.config.base_dir = path
    site = pywikibot.Site('en', 'wikipedia')
    page = pywikibot.Page(site, PAGE)
    text = page.text

def remove_markup(text):
    text = wtp.remove_markup(text, replace_tags=False)
    return re.sub(r'<ref.*?>.*?</ref>', '', text, flags=re.DOTALL).strip()

parsed = wtp.parse(text)

misconceptions = []
for section in parsed.sections:
    if section.level != 3:
        continue

    category = section.title

    for list in section.get_lists():
        for item in list.items:
            misconceptions.append((category, remove_markup(item)))

category, misconception = random.choice(misconceptions)

print(json.dumps({"category": category, "misconception": misconception}))
