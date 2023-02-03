cd ton-http-api

echo "Running api with ${TON_API_WEBSERVERS_WORKERS:-1} workers"
echo "ENVIRONMENT:"
printenv

gunicorn pyTON.main:app -k uvicorn.workers.UvicornWorker -w ${TON_API_WEBSERVERS_WORKERS:-1} --bind 0.0.0.0:${PUBLIC_PORT}
