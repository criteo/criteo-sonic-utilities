/opt/salt/scripts/criteo_fdbshow:
  file.managed:
    - source:
      - salt://{{ grains["sonic_build_version"] }}/criteo_fdbshow
    - mode: 755