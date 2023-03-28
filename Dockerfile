# Use the official miniconda3 base image
FROM continuumio/anaconda3

# Set the working directory
WORKDIR /app

# Copy the environment.yml file into the container
# COPY environment.yml .

# # Create the Conda environment based on the environment.yml file
# RUN conda env create -f environment.yml

# # Activate the Conda environment
# SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Copy the application source code into the container
COPY . .
RUN python -m pip install --upgrade pip
# create a new environment
RUN conda init
RUN conda create -n visgpt python=3.8

# activate the new environment
RUN conda activate visgpt
RUN export OPENAI_API_KEY=${{secrets.OPENAI_API_KEY }}
#  prepare the basic environments
RUN pip install -r requirements.txt
# Expose the port the app will run on
EXPOSE 1015

# Run the application
CMD ["python", "visual_chatgpt.py --load ImageCaptioning_cpu,Text2Image_cpu"]
