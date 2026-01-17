import { vi } from 'vitest'

// Mock handleError to prevent process.exit in tests
vi.mock('@/src/utils/handle-error', () => ({
  handleError: vi.fn((error) => {
    // Instead of calling process.exit, just throw the error
    throw error
  }),
}))

// Mock logger to prevent console spam in tests
vi.mock('@/src/utils/logger', () => ({
  logger: {
    error: vi.fn(),
    break: vi.fn(),
    log: vi.fn(),
    warn: vi.fn(),
    info: vi.fn(),
    success: vi.fn(),
  },
}))

// Mock getRegistryIcons to return empty object (for tests that don't need real icons)
vi.mock('@/src/registry/api', async () => {
  const actual = await vi.importActual('@/src/registry/api')
  return {
    ...actual,
    getRegistryIcons: vi.fn().mockResolvedValue({}),
  }
})
