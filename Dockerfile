# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code to the working directory
COPY . .

# Command to run the application using gunicorn
# Gunicorn is a production-ready WSGI server. UvicornWorker is used to run our ASGI app (FastAPI).
# The server will listen on the port specified by the PORT environment variable, provided by Heroku.
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:$PORT", "app.api:app"]
