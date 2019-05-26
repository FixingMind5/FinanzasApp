const functions = require('firebase-functions');
const SHA256 = require('crypto-js/hmac-sha256');
const admin = require('firebase-admin');
const requestpromise = require('request-promise');

const credentials = require('../firebase-auth.json');

admin.initializeApp({
  credential: admin.credential.cert(credentials),
  databaseURL: 'https://platzi-finanzas-31d69.firebaseio.com',
});

exports.accountkit = functions.https.onRequest(async (request, response) => {
    const accessToken = request.query.access_token || null;

    if (accessToken === null) {
      response.status(400).json({
        message: 'El token no puede estar vacio.'
      });
      return;
    }

    const facebookAppSecret = credentials.facebook.app_secret;
    const appSecretProof = SHA256(accessToken, facebookAppSecret);

    const urlSegment = `access_token=${accessToken}&appsecret_proof=${appSecretProof}`;
    const url = `https://graph.accountkit.com/v1.3/me/?${urlSegment}`;

    console.log(url);

    try {
      const result = await requestpromise({
        url,
        json: true
      });

      const token = await admin.auth().createCustomToken(result.id, result);
  
      response.json({ token });
    } catch (error) {
      console.log(error);
    }    
});
