FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app
ENV APP_NAME="FlaskAPP"
ENV ENV="test"
ENV VERSION="3.11"
EXPOSE 5000
CMD [ "python","app.py" ]
