export type File = {
  id: any,
  name: string,
  url: string,
}

export type UploadFileOptions = {
  base64: string,
  path: string,
  name: string,
  mimeType?: string,
  makePublic?: boolean,
};

export interface IFileService {
  uploadFile(options: UploadFileOptions): Promise<String | null>;
}