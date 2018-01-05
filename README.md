# mpegts-to-mp4-converter
## install
```sh
make
```

## m3u8-loader
it downloads all ts-parts of the m3u8-playlist and concats them to a single .ts file afterwards it encodes it with handbrake-cli to mp4 (preset: High Profile). this is all done with a docker-container. then the created mp4-file will be copied out of the docker-container to the specifed output-path on the host. in the end the docker-container will be deleted with all the workspace-files.
### usage
```sh
./process_m3u8.sh <m3u8-url> <output-file-path>
```
