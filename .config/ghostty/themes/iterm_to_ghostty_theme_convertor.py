import argparse
import sys
import xml.etree.ElementTree as ET
from string import Template

GHOSTTY_TEMPLATE = """
palette = 0=$ansi0
palette = 1=$ansi1
palette = 2=$ansi2
palette = 3=$ansi3
palette = 4=$ansi4
palette = 5=$ansi5
palette = 6=$ansi6
palette = 7=$ansi7
palette = 8=$ansi8
palette = 9=$ansi9
palette = 10=$ansi10
palette = 11=$ansi11
palette = 12=$ansi12
palette = 13=$ansi13
palette = 14=$ansi14
palette = 15=$ansi15
background = $background
foreground = $foreground
cursor-color = $cursor
selection-background = $selection_bg
selection-foreground = $selection_fg
"""


def float_to_hex(value):
    return format(round(value * 255), "02x")


def rgb_to_hex(color):
    red = color["red"]
    green = color["green"]
    blue = color["blue"]
    return f"#{float_to_hex(red)}{float_to_hex(green)}{float_to_hex(blue)}"


def iterm2ghostty_colors(colors):
    return {
        "ansi0": rgb_to_hex(colors["Ansi 0 Color"]),
        "ansi1": rgb_to_hex(colors["Ansi 1 Color"]),
        "ansi2": rgb_to_hex(colors["Ansi 2 Color"]),
        "ansi3": rgb_to_hex(colors["Ansi 3 Color"]),
        "ansi4": rgb_to_hex(colors["Ansi 4 Color"]),
        "ansi5": rgb_to_hex(colors["Ansi 5 Color"]),
        "ansi6": rgb_to_hex(colors["Ansi 6 Color"]),
        "ansi7": rgb_to_hex(colors["Ansi 7 Color"]),
        "ansi8": rgb_to_hex(colors["Ansi 8 Color"]),
        "ansi9": rgb_to_hex(colors["Ansi 9 Color"]),
        "ansi10": rgb_to_hex(colors["Ansi 10 Color"]),
        "ansi11": rgb_to_hex(colors["Ansi 11 Color"]),
        "ansi12": rgb_to_hex(colors["Ansi 12 Color"]),
        "ansi13": rgb_to_hex(colors["Ansi 13 Color"]),
        "ansi14": rgb_to_hex(colors["Ansi 14 Color"]),
        "ansi15": rgb_to_hex(colors["Ansi 15 Color"]),
        "background": rgb_to_hex(colors["Background Color"]),
        "foreground": rgb_to_hex(colors["Foreground Color"]),
        "cursor": rgb_to_hex(colors["Cursor Color"]),
        "selection_bg": rgb_to_hex(colors["Selection Color"]),
        "selection_fg": rgb_to_hex(colors["Selected Text Color"]),
    }


def main():
    parser = argparse.ArgumentParser(
        description="Convert iTerm2 themes to Ghostty colors."
    )
    parser.add_argument(
        "-f", "--file", required=True, help="The iTerm2 theme file path"
    )
    parser.add_argument("-o", "--output", help="Output file path (defaults to stdout)")
    args = parser.parse_args()

    tree = ET.parse(args.file)
    root = tree.getroot().find("dict")

    iterm2_colors = {}
    elements = list(root)
    for i in range(len(elements)):
        if elements[i].tag == "key" and "Color" in elements[i].text:
            name = elements[i].text
            color_dict = elements[i + 1]  # The following 'dict' element
            color_components = {}
            for j in range(len(color_dict)):
                if color_dict[j].tag == "key" and "Component" in color_dict[j].text:
                    component_name = color_dict[j].text.split()[0].lower()
                    component_value = float(color_dict[j + 1].text)
                    color_components[component_name] = component_value
            iterm2_colors[name] = color_components

    ghostty_colors = iterm2ghostty_colors(iterm2_colors)
    template = Template(GHOSTTY_TEMPLATE)
    output_content = template.substitute(ghostty_colors)

    if args.output:
        with open(args.output, "w") as output_file:
            output_file.write(output_content)
    else:
        sys.stdout.write(output_content)


if __name__ == "__main__":
    main()
