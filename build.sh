#!/usr/bin/env bash
set -o errexit

echo "Building React frontend..."
cd frontend-src
npm install
npm run build

echo "Moving build to backend..."
cd ..
rm -rf backend/frontend
mkdir -p backend/frontend
cp -r frontend-src/build/* backend/frontend/

echo "Setting up Python backend..."
cd backend
pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate

echo "Build completed!"