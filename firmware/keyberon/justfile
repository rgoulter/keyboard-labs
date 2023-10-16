uf2_drive := "/run/media/`whoami`/BlackPill"

make-uf2 target:
  make {{target}}.uf2

flash-uf2 target: (make-uf2 target)
  #!/usr/bin/env bash
  echo "waiting for uf2 drive: {{uf2_drive}}"
  while [ ! -d {{uf2_drive}}/ ]; do
    sleep 1
  done
  echo "copying to {{uf2_drive}}"
  cp ./{{target}}.uf2 {{uf2_drive}}/

make-and-flash target: (make-uf2 target) (flash-uf2 target)
