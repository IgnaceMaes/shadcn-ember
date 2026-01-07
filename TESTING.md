# Testing Guide for shadcn-ember CLI

This guide will help you test your converted shadcn-ember CLI to ensure all phases of the conversion are working correctly.

## Prerequisites

✅ Dependencies installed: `pnpm install`
✅ CLI built successfully: `pnpm build`

## Test Checklist

### 1. Basic CLI Functionality Tests

#### Test 1.1: Verify CLI is Accessible
```bash
cd packages/cli
node dist/index.js --version
node dist/index.js --help
```
**Expected:** Should show version and help menu with "shadcn-ember" branding

#### Test 1.2: Check CLI Name
```bash
node dist/index.js --help
```
**Expected:** Should display `shadcn-ember` as the CLI name (not `shadcn-vue`)

---

### 2. Unit Tests

#### Test 2.1: Run All Unit Tests
```bash
cd packages/cli
pnpm test
```
**Expected:** All tests should pass. Look for:
- Registry API tests
- Transformer tests
- Utility tests
- Framework detection tests

#### Test 2.2: Run Tests in Watch Mode (for development)
```bash
pnpm test:ui
```
**Expected:** Vitest UI should open, showing all test suites

---

### 3. Command-Specific Tests

#### Test 3.1: `init` Command
```bash
# Create a temporary test directory
mkdir -p /tmp/test-ember-app
cd /tmp/test-ember-app

# Initialize an Ember project (or use existing one)
# Then test the CLI init command
node /Users/ignace/Documents/projects/shadcn-ember/packages/cli/dist/index.js init
```
**Expected:** 
- Should detect Ember framework
- Should prompt for configuration
- Should NOT mention Vue/Nuxt
- Should reference shadcn-ember documentation URLs

#### Test 3.2: `add` Command (requires init first)
```bash
node /Users/ignace/Documents/projects/shadcn-ember/packages/cli/dist/index.js add button
```
**Expected:**
- Should attempt to fetch from your registry URL
- Should show proper error messages if registry not set up
- Should NOT reference shadcn-vue.com

#### Test 3.3: `info` Command
```bash
node /Users/ignace/Documents/projects/shadcn-ember/packages/cli/dist/index.js info
```
**Expected:** Should display project information with Ember-specific details

---

### 4. Phase-Specific Validation

#### Phase 1: Branding & Package Identity ✓
- [x] package.json name is "shadcn-ember"
- [x] Repository URL points to your repo
- [x] Keywords include ember, glimmer, shadcn-ember
- [ ] Run: `cat packages/cli/package.json | grep -E "name|keywords|repository"`

#### Phase 2: Registry & Constants ✓
- [ ] Check constants.ts for registry URL:
  ```bash
  grep -n "REGISTRY_URL" packages/cli/src/registry/constants.ts
  ```
- [ ] Check error messages:
  ```bash
  grep -rn "shadcn-vue.com" packages/cli/src --exclude-dir=node_modules
  ```
  **Expected:** Should return NO results (or only in test fixtures)

#### Phase 3: MCP Updates ✓
- [ ] Check MCP configuration:
  ```bash
  grep -n "shadcn" packages/cli/src/mcp/index.ts
  grep -n "SHADCN_CLI_COMMAND" packages/cli/src/mcp/utils.ts
  ```
- [ ] Test MCP command:
  ```bash
  node dist/index.js mcp --help
  ```

#### Phase 4: Framework Detection ✓
- [ ] Check frameworks.ts:
  ```bash
  cat packages/cli/src/registry/frameworks.ts
  ```
  **Expected:** Should contain Ember frameworks, NOT Vue/Nuxt

#### Phase 5: Transformers ✓
- [ ] List transformers:
  ```bash
  ls -la packages/cli/src/utils/transformers/
  ```
- [ ] Check for Vue-specific code:
  ```bash
  grep -rn "vue-metamorph\|@vue/compiler\|<script setup>" packages/cli/src/utils/transformers/
  ```

---

### 5. Integration Tests

#### Test 5.1: Full Workflow Test
```bash
# 1. Create test Ember app
cd /tmp
npx ember-cli new test-shadcn-ember --skip-git
cd test-shadcn-ember

# 2. Run init
node /Users/ignace/Documents/projects/shadcn-ember/packages/cli/dist/index.js init

# 3. Try to add a component (will fail without registry, but should error gracefully)
node /Users/ignace/Documents/projects/shadcn-ember/packages/cli/dist/index.js add button
```

#### Test 5.2: Test with Existing Ember App
```bash
# Navigate to your Ember app (apps/v4)
cd /Users/ignace/Documents/projects/shadcn-ember/apps/v4

# Run info command
node ../../packages/cli/dist/index.js info

# Test init (should detect existing config)
node ../../packages/cli/dist/index.js init
```

---

### 6. TypeScript & Type Checking

#### Test 6.1: Type Check
```bash
cd packages/cli
pnpm typecheck
```
**Expected:** No TypeScript errors

#### Test 6.2: Check Build Output Types
```bash
ls -la dist/*.d.ts
```
**Expected:** Should see .d.ts declaration files

---

### 7. Registry Tests (when registry is ready)

#### Test 7.1: Test Registry API
```bash
# Update registry URL in constants.ts to your live registry
# Then test fetching
node dist/index.js search button
```

#### Test 7.2: Test Component Installation
```bash
node dist/index.js add <component-name>
```

---

## Common Issues & Fixes

### Issue 1: "vue-metamorph" Warning
**Status:** ⚠️ Expected during build
**Fix:** This is a Vue-specific dependency that needs to be removed or replaced with Ember-equivalent transformers

### Issue 2: Registry URL 404
**Status:** ⚠️ Expected if registry not deployed
**Fix:** Update `REGISTRY_URL` in `src/registry/constants.ts` once your registry is live

### Issue 3: Framework Detection Fails
**Status:** 🔴 Critical
**Test:** 
```bash
node dist/index.js init
```
**Fix:** Check `get-project-info.ts` for proper Ember detection logic

---

## Automated Test Script

Save this as `test-cli.sh`:

```bash
#!/bin/bash
set -e

echo "🧪 Testing shadcn-ember CLI"
echo "=========================="

cd packages/cli

echo "✅ Step 1: Type Check"
pnpm typecheck

echo "✅ Step 2: Build"
pnpm build

echo "✅ Step 3: Run Unit Tests"
pnpm test

echo "✅ Step 4: Check CLI Version"
node dist/index.js --version

echo "✅ Step 5: Check CLI Help"
node dist/index.js --help

echo "✅ Step 6: Verify Branding"
if node dist/index.js --help | grep -q "shadcn-ember"; then
  echo "✅ CLI name is correct"
else
  echo "❌ CLI name is incorrect"
  exit 1
fi

echo "=========================="
echo "🎉 All tests passed!"
```

Make it executable:
```bash
chmod +x test-cli.sh
./test-cli.sh
```

---

## Next Steps After Testing

1. **Fix vue-metamorph dependency:** Remove or replace in transformers
2. **Set up registry:** Deploy your component registry
3. **Update documentation URLs:** Ensure all links point to your docs
4. **Test with real Ember projects:** Validate against actual Ember apps
5. **Update tests:** Modify test fixtures to use Ember component structures
6. **CI/CD:** Set up automated testing in GitHub Actions

---

## Quick Test Commands

```bash
# In packages/cli directory:

# Build and test quickly
pnpm build && pnpm test

# Check for Vue references
grep -rn "shadcn-vue" src/ --exclude-dir=node_modules

# Test CLI commands
node dist/index.js --help
node dist/index.js info
node dist/index.js search button
```
