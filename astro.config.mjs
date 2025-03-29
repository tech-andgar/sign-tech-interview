import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

const port = 4300;
const localHostUrl = `http://localhost:${port}`;
const liveUrl = "https://interview.signlanguagetech.com";
const isProd = import.meta.env.PROD;

export default defineConfig({
  server: { port },
  site: isProd ? liveUrl : localHostUrl,
  integrations: [
    starlight({
      plugins: [],
      title: {
        "en": "Sign Tech Interview",
        "es": "Sign Tech Interview en Español",
      },
      lastUpdated: true,
      editLink: {
        baseUrl: 'https://github.com/signlanguagetech/crack-interview/edit/main/',
      },
      social: {
        github: "https://github.com/signlanguagetech/crack-interview",
        youtube: "https://www.youtube.com/@SignLanguageTech",
        linkedin: "https://www.linkedin.com/company/sign-language-tech"
      },
      defaultLocale: 'root',
      locales: {
        root: {
          label: 'English',
          lang: 'en',
        },
        "es": {
          label: "Español",
          locale: "es",
        }
      },
      sidebar: [
        {
          label: "Skills",
          autogenerate: { directory: "skills/" },
          collapsed: false,
        }
      ],
      customCss: [
        './src/styles/custom.css',
      ],
      components: {
        PageTitle: './src/components/PageTitle.astro',
        Footer: './src/components/overrides/Footer.astro',
      },
      head: [
        {
          tag: 'script',
          attrs: {
            src: 'https://www.googletagmanager.com/gtag/js?id=G-EM5400YMC3',
            async: true,
          }
        },
        {
          tag: 'script',
          content: `
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', 'G-EM5400YMC3');
          `
        }
      ],
    }),
  ],
});
