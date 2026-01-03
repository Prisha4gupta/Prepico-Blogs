# Contributing to Prepico Blogs

Thank you for your interest in contributing! Here's how you can help:

## Development Setup

1. Fork and clone the repository
2. Install dependencies: `npm install`
3. Create a feature branch: `git checkout -b feature/your-feature`
4. Make your changes
5. Test locally: `npm run dev`
6. Commit with clear messages
7. Push and create a Pull Request

## Code Style

- Use Vue 3 Composition API with `<script setup>`
- Follow Tailwind CSS utility-first approach
- Keep components focused and reusable
- Add comments for complex logic

## Adding New Features

### New Block Types

To add a new content block type:

1. Add the block type to the editor select dropdown in `AdminEditorPage.vue`
2. Add rendering logic in `BlogViewPage.vue`
3. Update the `blogStore.js` if needed
4. Test in the admin editor

### New Pages

1. Create a new `.vue` file in `src/pages/`
2. Add the route to `src/router/index.js`
3. Import and reference the component
4. Test navigation

## Testing

- Test all CRUD operations in the admin editor
- Verify responsive design on mobile and desktop
- Check article rendering with all block types
- Validate navigation flow

## Pull Request Guidelines

- Describe the changes clearly
- Reference any related issues
- Include screenshots for UI changes
- Keep PRs focused on single features

Thank you for contributing!
