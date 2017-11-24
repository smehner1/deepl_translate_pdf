# deepl_translate_pdf

This little shellscript translates PDF files to a Text file using deepl-translator-cli.

This shellscript converts the pdf using `pdftotext` (from poppler-utils) to a text file. After some little preperation the text would be translated in sections. 

If one section is shorter than 100 chars it will not translated (to save requests). Also section with more than 5000 chars are not translated, because the deepl api seems to have problems then.

At the end you have the translated text in an extra text file.

## Installation

To use this shellscript you will need:
* deepl-translator-cli (see [here](https://github.com/vsetka/deepl-translator-cli) or [here](https://linoxide.com/linux-how-to/deepl-command-line-language-translator-tool-linux/))
* poppler-utils

## Usage

To translate a pdf file you simple have to type something like this: 
    # ./deepl_translate_pdf filename.pdf
 
This will take a moment. To indicate that the script is working there are "." (not translated section) and ":" (translated section).
By default it detects the source language and translated to German. If you want to change it, you can define a second call parameter or replace "DE" with "FR", "EN" and so on.

Have fun!
    


