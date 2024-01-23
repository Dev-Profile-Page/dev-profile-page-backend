export function validateAuthorizationHeader(headerValue?: string): boolean {
  if(typeof headerValue !== 'string') return false;
  if(headerValue.length === 0) return false;
  if(!(headerValue.includes('Bearer'))) return false;

  const fragments = headerValue.split(' ');

  if(fragments.length !== 2) return false;
  if(fragments[1].length === 0) return false;

  return true;
}