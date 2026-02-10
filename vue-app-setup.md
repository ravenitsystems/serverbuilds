
Install the vue modules
```
npm install vue@latest vue-router@latest @vitejs/plugin-vue
```

vite.config.js
```
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from "@vitejs/plugin-vue";
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [
        vue(),
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
        tailwindcss(),
    ],
    server: {
        watch: {
            ignored: ['**/storage/framework/views/**'],
        },
    },
    resolve: {
        alias: {
            vue: "vue/dist/vue.esm-bundler.js",
        },
    },
});
```

Create a new file with path ./resources/js/App.vue
```
<template>
    <h2>
        Main App Component
    </h2>
</template>
```

Edit the ./resources/js/app.js file to be like
```
import "./bootstrap";
import { createApp } from "vue";

import App from "./App.vue";

createApp(App).mount("#app");
```

Edit the ./resources/views/welcome.blade.php
```
<head>
    @vite(['resources/js/app.js'])
    @vite(['resources/css/app.css'])
</head>

<body>
    <div id="app"></div>
</body>
```


