# Use the official Python image
# FROM python:3.10
FROM python:3.8.18

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file first to leverage Docker cache
# COPY requirements.txt .
COPY  req_dl4.txt .

# Install required Python packages
# RUN pip install -r requirements.txt --default-timeout=100 future
RUN pip install -r req_dl4.txt --default-timeout=100 future

# Copy the rest of the application files to the container's working directory
COPY . .

# Expose the port that Streamlit will run on
EXPOSE 8080

# Command to run your Streamlit application
CMD ["streamlit", "run", "chatbot_app.py"]
