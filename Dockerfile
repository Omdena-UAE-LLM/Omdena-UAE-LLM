# # Use the official Python image
# # FROM python:3.10
# FROM python:3.8.18

# # Set the working directory inside the container
# WORKDIR /app

# # Copy the requirements.txt file first to leverage Docker cache
# # COPY requirements.txt .
# COPY  req_dl4.txt .

# # Install required Python packages
# # RUN pip install -r requirements.txt --default-timeout=100 future
# RUN pip install -r req_dl4.txt --default-timeout=100 future

# # Copy the rest of the application files to the container's working directory
# COPY . .

# # Expose the port that Streamlit will run on
# EXPOSE 8080

# # Command to run your Streamlit application
# CMD ["streamlit", "run", "chatbot_app.py"]

#  ========================================
#  ========================================
#  ========================================

# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.11-slim

# Allow statements and log messages to immediately appear in the logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
RUN pip install --no-cache-dir -r requirements.txt

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 flask:app
