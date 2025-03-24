# Crack Interview

A comprehensive resource collection and practice platform to help you prepare for technical interviews.

## Overview

This repository contains curated resources, practice problems, and strategies to help you succeed in technical interviews across various domains including algorithms, data structures, system design, and behavioral questions.

## Contents

- **Algorithms**: Common algorithmic challenges and their solutions
- **Data Structures**: Implementation and usage of essential data structures
- **System Design**: Approaches to solving system design problems
- **Behavioral Questions**: Preparation for non-technical interview components
- **Mock Interviews**: Practice scenarios and feedback templates

## Getting Started

```bash
git clone git@github.com:signlanguagetech/crack-interview.git
cd crack-interview
```

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                | Action                                           |
| :--------------------- | :----------------------------------------------- |
| `pnpm install`         | Installs dependencies                            |
| `pnpm dev`             | Starts local dev server at `localhost:4321`      |
| `pnpm build`           | Build your production site to `./dist/`          |
| `pnpm preview`         | Preview your build locally, before deploying     |
| `pnpm astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `pnpm astro -- --help` | Get help using the Astro CLI                     |

## How to Use

1. Browse the different sections based on your interview preparation needs
2. Solve practice problems in your preferred programming language
3. Review the provided solutions after attempting problems
4. Track your progress using the provided templates
## Thanking all Awesome Contributors :heart:

[![Contributors](https://contrib.rocks/image?repo=signlanguagetech/crack-interview)](https://github.com/signlanguagetech/crack-interview/graphs/contributors)

Contributions of any kind are welcome!

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

# Preview Environments with Surge.sh

This project uses GitHub Pages for production deployment and Surge.sh for Pull Request previews.

## Setting up Surge.sh for PR Previews

To enable automatic PR previews with Surge.sh:

1. **Create a Surge.sh account**
   ```
   npm install -g surge
   surge login
   ```

2. **Get your Surge.sh token**
   ```
   surge token
   ```

3. **Configure the secrets in GitHub**
   
   In your GitHub repository, go to Settings > Secrets > Actions and add:
   
   - `SURGE_TOKEN`: The token obtained in the previous step
   - `SURGE_LOGIN`: Your Surge.sh email address

## How It Works

- Each time a PR is created or updated, it's automatically deployed to a unique Surge.sh domain
- The workflow leaves a comment with the preview link on the PR
- When the PR is closed or merged, the preview is automatically removed

## Lifecycle

1. **PR Creation/Update**: Deployed to `https://pr-{number}-{repository}.surge.sh`
2. **PR Close/Merge**: Preview is automatically removed
3. **Production**: The main site is deployed to GitHub Pages when changes reach the `main` branch
