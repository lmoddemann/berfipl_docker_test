# Use the official Ubuntu image as the base
FROM ubuntu:22.04

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    build-essential \
    cmake \
    gfortran \
    python3 \
    python3-pip \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Add conda to PATH
ENV PATH="/opt/conda/bin:$PATH"

# Install OpenModelica 
RUN echo "deb https://build.openmodelica.org/apt jammy nightly" | tee /etc/apt/sources.list.d/openmodelica.list \
    && wget -q https://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add - \
    && apt-get update \
    && apt-get install -y openmodelica \
    && apt-get install -y vim

# Set environment variables for OpenModelica
ENV PATH="/opt/openmodelica/bin:$PATH"

RUN git clone https://github.com/lmoddemann/berfipl_docker_test.git 

# Set the working directory to your cloned repo
WORKDIR /berfipl_docker_test
RUN conda env create -f environment.yml

COPY example.mo .

# Create conda environment from the environment.yml file (assuming it is in the repo)

# Activate the environment
RUN echo "source activate myenv" > ~/.bashrc
ENV PATH /opt/conda/envs/myenv/bin:$PATH

RUN chmod +x example.mo
# Define the entrypoint to run your Python script
# ENTRYPOINT ["python3", "your_script.py"]
CMD ["omc", "example.mo"]