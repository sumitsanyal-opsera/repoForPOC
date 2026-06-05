/**
 * Custom exception thrown by SecurityUtil when CRUD or FLS access checks fail.
 *
 * Kept as a top-level class (not an inner class of SecurityUtil) so that
 * callers can catch it without importing SecurityUtil itself, avoiding
 * circular or unnecessary dependencies.
 */
public class SecurityException extends Exception {}