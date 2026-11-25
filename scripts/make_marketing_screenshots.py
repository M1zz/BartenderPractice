#!/usr/bin/env python3
"""스토어 스크린샷 합성: 원본 캡처(docs/screenshots/raw) + 헤드라인 → HTML → 헤드리스 Chrome.

원본 다시 찍기 (DEBUG 빌드):  xcrun simctl launch <UDID> com.leeo.BartenderPractice -ScreenshotScene <home|practice|result|exam|recipe>
실행:  python3 scripts/make_marketing_screenshots.py   →  docs/screenshots/marketing/ko/
"""
import pathlib, shutil, subprocess, tempfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
RAW = ROOT / "docs/screenshots/raw"
OUT = ROOT / "docs/screenshots/marketing/ko"
WORK = pathlib.Path(tempfile.gettempdir()) / "bartender-shots"  # Chrome 은 한글 경로로 저장하지 못해 여기서 그린 뒤 옮긴다
CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# (원본 이름, 레이아웃, 헤드라인, 서브카피)
SHOTS = [
    ("02-practice", "hero", "골라 보며 외우는<br>조주기능사 실기", "잔, 재료, 조주법, 가니쉬를 직접 골라요"),
    ("03-result",   "tilt", "고르면 바로<br>100점 만점 채점", "틀린 곳은 정답과 나란히 보여 줘요"),
    ("04-exam",     "hero", "3잔 7분,<br>실제 시험처럼", "모의고사로 시간 감각까지 연습해요"),
    ("01-home",     "tilt", "약한 칵테일을<br>골라 다시 연습", "평균 점수와 합격률을 한눈에 봐요"),
    ("05-recipe",   "dark", "표준 레시피<br>40가지 그대로", "베이스별로 찾아보고 바로 실습해요"),
]

DEVICES = {  # 이름 접두사, 캔버스, 원본 폴더, 기기 폭, 모서리
    "iphone": dict(prefix="", W=1242, H=2688, raw=RAW, dev=900, r=110, pad=24, head=96, sub=48),
    "ipad":   dict(prefix="ipad-", W=2064, H=2752, raw=RAW / "ipad", dev=1640, r=70, pad=30, head=128, sub=60),
}

CSS = """
*{{margin:0;padding:0;box-sizing:border-box}}
html,body{{width:{W}px;height:{H}px;overflow:hidden}}
body{{background:linear-gradient(180deg,#f8f1e8,#efe3d6);font-family:-apple-system,"Apple SD Gothic Neo",sans-serif;text-align:center}}
.h{{font-size:{head}px;font-weight:800;color:#2a1824;letter-spacing:-2px;line-height:1.22;margin-top:{top}px}}
.s{{font-size:{sub}px;font-weight:600;color:#c4633f;margin-top:{gap}px;letter-spacing:-.5px}}
.wrap{{display:flex;justify-content:center;margin-top:{gap2}px;perspective:2600px}}
.dev{{width:{dev}px;background:#1b141c;border-radius:{r}px;padding:{pad}px;box-shadow:0 60px 120px rgba(60,20,30,.28)}}
.dev img{{width:100%;display:block;border-radius:{ri}px}}
body.tilt .dev{{transform:rotateY(-12deg) rotateX(3deg)}}
body.dark{{background:linear-gradient(180deg,#3a1c2c,#171322)}}
body.dark .h{{color:#faf0e2}} body.dark .s{{color:#e08660}}
body.dark .dev{{box-shadow:0 0 160px rgba(224,134,96,.25),0 60px 120px rgba(0,0,0,.5)}}
"""

def main():
    OUT.mkdir(parents=True, exist_ok=True)
    WORK.mkdir(exist_ok=True)
    for name, d in DEVICES.items():
        k = d["W"] / 1242 if name == "iphone" else 1.0
        css = CSS.format(W=d["W"], H=d["H"], head=d["head"], sub=d["sub"], top=int(230 * k) if name == "iphone" else 200,
                         gap=40, gap2=110 if name == "iphone" else 120, dev=d["dev"], r=d["r"], pad=d["pad"], ri=d["r"] - d["pad"])
        for i, (raw, layout, head, sub) in enumerate(SHOTS, 1):
            img = (d["raw"] / f"{raw}.png").as_uri()
            html = f'<!doctype html><html><head><meta charset="utf-8"><style>{css}</style></head><body class="{layout}">' \
                   f'<div class="h">{head}</div><div class="s">{sub}</div><div class="wrap"><div class="dev"><img src="{img}"></div></div></body></html>'
            page = WORK / f"{name}-{i}.html"
            page.write_text(html, encoding="utf-8")
            out = OUT / f"{d['prefix']}0{i}-{raw[3:]}.png"
            tmp = WORK / f"{name}-{i}.png"
            subprocess.run([CHROME, "--headless=new", f"--screenshot={tmp}", f"--window-size={d['W']},{d['H']}",
                            "--force-device-scale-factor=1", "--hide-scrollbars", "--allow-file-access-from-files", page.as_uri()],
                           check=True, capture_output=True)
            shutil.move(tmp, out)
            print("rendered", out.relative_to(ROOT))

if __name__ == "__main__":
    main()
