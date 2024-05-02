#!/bin/bash

fp_qmd="$1"

# # download template if not exist
# url_dropbox="https://www.dropbox.com/scl/fo/65lyqcspfindi4fqqc5dv/AA_cCzOHXOItJo4zyA3tAdY"
# dp_temp="template"
# fn_temp_csl="ieee-with-url.csl"
# fn_temp_pptx="template_for_pandoc.pptx"
# fn_temp_zip="template.zip"

# fp_temp_csl="${dp_temp}/${fn_temp_csl}"
# fp_temp_pptx="${dp_temp}/${fn_temp_pptx}"
# fp_temp_zip="${fn_temp_zip}"
# mkdir -p "${dp_temp}"
# if [ ! -f "${fp_temp_csl}" ]; then
# 	echo Downloadin file: "${url_dropbox}/${fn_temp_csl}"
# 	wget "${url_dropbox}/${fn_temp_csl}" -O ${fp_temp_csl}
# fi

# if [ ! -f "${fp_temp_pptx}" ]; then
# 	echo Downloadin file: "${url_dropbox}/${fn_temp_pptx}"
# 	wget "${url_dropbox}/${fn_temp_pptx}" -O ${fp_temp_pptx}
# fi

# if [ ! -f "${fp_temp_csl}" ] || [ ! -f "${fp_temp_pptx}" ]; then
# 	echo Downloadin file: "${url_dropbox}/${fn_temp_zip}"
# 	wget "${url_dropbox}/${fn_temp_zip}" -O ${fp_temp_zip}
# 	unzip "${fp_temp_zip}"
# 	rm -rf "${fp_temp_zip}"
# fi

if [ ! -z "${fp_qmd}" ]; then
	if [ "${fp_qmd}" ]; then
		dp_app="${PWD}"
		dn_qmd="$(dirname "${fp_qmd}")"
		fn_qmd="$(basename "${fp_qmd}")"
		cd "${dn_qmd}"
		echo "Processing files under the directory: ${dn_qmd}"

		# --no-watch-inputs
		# quarto preview "${fn_qmd}" --no-browser
		echo -e "Convert qmd to pptx for file: ${c_yellow}${fp_qmd}${c_white}"
		# envsubst < "${fn_qmd}" | quarto render - --cache-refresh
		# quarto render "${fn_qmd}" --cache-refresh
		quarto render "${fn_qmd}" --no-cache
		# convert pptx to pdf
		LANG=ja_JP.utf8 libreoffice \
			--headless \
			--invisible \
			--language=ja \
			--nologo --nofirststartwizard \
			--convert-to pdf:writer_pdf_Export \
			*.pptx
		ls -al *.pptx *.pdf

		cd "${dp_app}"
	else
		echo -e "Missing file: ${c_red}${fp_qmd}${c_white}"
	fi
else
	echo "Please input qmd file path"
fi