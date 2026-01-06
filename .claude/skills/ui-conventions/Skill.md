---
name: UI Conventions
description: UI/UX patterns and conventions for this project. Use for any frontend work - components, layouts, styling, notifications, forms. Contains learned preferences for Quasar/Vue or Next.js/React patterns.
---

# UI Conventions

Learned UI/UX patterns and component preferences. Updated by the Reflect skill.

## Last Updated
2025-01-28

## Components

### Buttons
- Use Quasar's `q-btn` for all buttons
- Never create custom button components unless absolutely necessary
- Preferred icon: `mdi-arrow-left` for back navigation

### Dialogs and Modals
- **CRITICAL:** Never use browser `alert()`, `confirm()`, or `prompt()`
- Always use Quasar's dialog system
- For notifications, use `$q.notify()` plugin

### Forms
- Use Quasar Form components with validation
- Always show loading states during async submission
- Disable submit button while submitting

### Notifications

**Never:**
```javascript
alert('Error occurred')  // ❌ FORBIDDEN
```

**Always:**
```javascript
$this.$q.notify({
  type: 'positive',  // or 'negative', 'warning', 'info'
  message: 'Success!',
  position: 'top'
})
```

## Layout

### Navigation
- Use `q-layout` with `q-header`, `q-drawer`, `q-page-container`
- Back button should be top-left in header
- Mobile: drawer for navigation, Desktop: drawer or tabs

### Responsive Design
- Mobile-first approach
- Test at 375px, 768px, 1024px breakpoints
- Hide desktop-only elements on mobile with `$q.screen.gt.md`

## Styling

### Colors
- Use Quasar's color palette (primary, secondary, accent, etc.)
- Define project colors in `quasar.variables.scss`
- Never hardcode hex colors in components

### Spacing
- Use Quasar's spacing classes (`q-pa-md`, `q-gutter-sm`, etc.)
- Consistent padding: `q-pa-md` for cards, `q-pa-sm` for form elements

## Accessibility

### ARIA Labels
- Always add labels to icon-only buttons
- Use descriptive labels for screen readers
```html
<q-btn icon="mdi-close" aria-label="Close dialog" />
```

### Keyboard Navigation
- All interactive elements must be keyboard accessible
- Use `tabindex` carefully (avoid if possible)
- Test with Tab, Enter, and Escape keys

## Performance

### Images
- Use `q-img` for lazy loading
- Optimize images before adding to project
- Use WebP format when browser support allows

### Lists
- Use virtual scrolling for lists > 100 items (`q-virtual-scroll`)
- Avoid rendering all items at once

## Learned Patterns

*This section grows as the Reflect skill learns from sessions*

### Session 2025-01-28
- Learned: User prefers `$q.notify` over `Notify.create` API
- Learned: Always add `:disable="loading"` to submit buttons
