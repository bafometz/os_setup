#!/bin/bash

set -eu

extract() {
    case $(file -b "$1") in
      *tar.bz2) tar xjf "$1" ;;
      *tar.gz|*.tgz) tar xzf "$1" ;;
      *tar.xz) tar xJf "$1" ;;
      *zip) unzip "$1" ;;
      *7z) 7z x "$1" ;;
      *rar) unrar x "$1" ;;
      *gzip|*.gz) gunzip "$1" ;;
      *bzip2|*.bz2) bunzip2 "$1" ;;
      *xz) unxz "$1" ;;
      *) echo "Unknown archive type: $1" ;;
    esac
}


fonts_url=("https://www.fontsquirrel.com/fonts/download/go"
 "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Go-Mono.zip"
 "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lilex.zip")

download_file="go.zip"
unzip_folder="go_fonts"

cd "/tmp"
rm -rf "${download_file}" 
rm -rf "${unzip_folder}"

for url in "${fonts_url[@]}"
do
  rm -rf "${download_file}" 
  rm -rf "${unzip_folder}"

  echo "Start download: ${url}"
  curl -L --output "${download_file}" "${url}" 1> /dev/null 2> /dev/null

  echo "Download done: ${download_file}"

  echo "Unzip: ${download_file} to ${unzip_folder}"
  unzip "${download_file}" -d "${unzip_folder}" 1> /dev/null 2> /dev/null

  cd "/tmp/${unzip_folder}"
  echo "Install go fonts"
  find . -type f -name "*.ttf" -exec cp -f {} "/home/${USER}/.local/share/fonts" \; 1> /dev/null 2> /dev/null
  echo "All installed"
  cd "../"

  echo  "Cleanup"
  rm -rf "${download_file}" 
  rm -rf "${unzip_folder}"
  echo "
  
  "
done