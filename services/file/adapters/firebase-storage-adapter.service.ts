import { initializeApp, cert } from 'firebase-admin/app';
import { getStorage } from 'firebase-admin/storage';
import { Bucket } from '@google-cloud/storage';
import { PassThrough } from 'stream';

import { IFileService, UploadFileOptions } from '../file.types';

const serviceAccount = require(process.env.FIREBASE_SERVICE_ACCOUNT_FILE_PATH);


export class FirebaseStorageAdapter implements IFileService {
  private bucket: Bucket;

  constructor() {
    initializeApp({
      credential: cert(serviceAccount),
      storageBucket: process.env.FIREBASE_STORAGE_BUCKET_URL,
    });

    this.bucket = getStorage().bucket();
  }

  async uploadFile({
      base64,
      path,
      name,
      mimeType='image/png',
      makePublic = false
    }: UploadFileOptions
  ): Promise<String | null> {
    return new Promise(async (resolve, reject) => {
      const file = this.bucket.file(`${path}/${name}`);

      const bufferStream = new PassThrough();
      bufferStream.end(Buffer.from(base64, 'base64'));

      bufferStream.pipe(file.createWriteStream({
        metadata: {
          contentType: mimeType,
        }
      })).on('error', error => {
        console.log(error);
        reject(error);
      }).on('finish', async () => {
        if(makePublic) {
          await file.makePublic();
          resolve(file.publicUrl());
        } else {
          resolve(null);
        }
      });
    });
  }
}
