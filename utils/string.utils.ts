// ! NOTE: This doesn't handle all the scenarios. For now simple stripping is enough
export function stripHTML(string: string): string {
  return string.replace(/<[^>]*>?/gm, '');
}

// ! NOTE: Is only removes \n \r and \t as of now.
export function removeEscapeCharacters(string: string): string {
  return string.replace(/[\n\r\t]/g, '');
}