FROM python:3.13-alpine AS build
WORKDIR /usr/src/app

COPY requirements.txt  .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .


FROM alpine:3.21
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/ ./
COPY --from=build /usr/local/lib/ /usr/local/lib/
COPY --from=build /usr/local/bin/ /usr/local/bin/
EXPOSE 5000
CMD ["flask", "--app","hello_py","run", "--host=0.0.0.0"]




