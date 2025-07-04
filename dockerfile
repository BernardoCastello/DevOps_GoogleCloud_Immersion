FROM python:3.13.5-alpine3.22

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /code

# Install system dependencies
RUN apk update && apk add --no-cache gcc musl-dev libffi-dev sqlite


# Install Python dependencies
COPY requirements.txt /code/
RUN pip install --upgrade pip && pip install -r requirements.txt && pip install uvicorn

# Copy project
COPY . /code/

# Expose port (adjust if your app uses a different port)
EXPOSE 8000

# Default command: run with Uvicorn (adjust the app import if needed)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]