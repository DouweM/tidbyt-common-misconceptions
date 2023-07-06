load("render.star", "render")
load("pixlib/file.star", "file")
load("pixlib/const.star", "const")
load("pixlib/font.star", "font")

def main(config):
  result = file.exec("misconception.py")

  category = result["category"]
  misconception = result["misconception"]

  title_font = "CG-pixel-3x5-mono"
  title_height = font.height(title_font) + 2
  fact_height = const.HEIGHT - title_height

  return render.Root(
    render.Column(
      expanded=True,
      children=[
        render.Box(
          height=title_height,
          color="#fff",
          child=render.Text("Misconception", font=title_font, color="#000")
        ),
        render.Marquee(
          scroll_direction="vertical",
          offset_start=fact_height,
          height=fact_height,
          width=const.WIDTH,
          child=render.Column(
            children=[
              render.WrappedText(category + ":", font=title_font),
              render.WrappedText(misconception),
            ]
          )
        )
      ]
    )
  )
