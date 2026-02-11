

### If build is failing execute in the project directory
```
rm -rf node_modules package-lock.json
npm cache verify
npm install
npm run prod
```
