{%- from 'conda/settings.sls' import install_prefix with context -%}

include:
  - conda
  - system.base

bokeh-install:
  cmd.run:
    - name: {{ install_prefix }}/bin/conda install bokeh -y -q
    - require:
      - sls: conda

dask-install:
  cmd.run:
    - name: {{ install_prefix }}/bin/conda install dask -y -q -c conda-forge
    - require:
      - sls: conda

distributed-install:
  cmd.run:
    - name: {{ install_prefix }}/bin/conda install distributed -y -q -c conda-forge
    - require:
      - sls: conda

update-pyopenssl:
  cmd.run:
    - name: CONDA_SSL_VERIFY=false {{ install_prefix }}/bin/conda update pyopenssl
    - require:
      - sls: conda

update-pandas:
  cmd.run:
    - name: {{ install_prefix }}/bin/conda update pandas
    - require:
      - update-pyopenssl
      - pip: distributed-install
