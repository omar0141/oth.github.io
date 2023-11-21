'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "9cd599a3523898e6a12e13ec787da50a",
".git/config": "9b18f296dc6859d0930d6e55b0a9355d",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "4dce71e3893433f6ab557862477c0d38",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "6ce06ec3db4d1b4524d028cf7bba3442",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "29f2410597b9d62949b6b87b1dc636c0",
".git/logs/refs/heads/main": "29f2410597b9d62949b6b87b1dc636c0",
".git/logs/refs/remotes/origin/HEAD": "1e05502a6b86e23198f760b1ce6a88a0",
".git/logs/refs/remotes/origin/main": "c8dccad00f1b2a25de36e5e17ab2c526",
".git/objects/06/7f400b14c33963e3f5ce53a7144596c2f17002": "0579463cca4ae4f033c0dfb7c9e7cc7b",
".git/objects/06/8fe813363f3ad4c93a249380ff7466e66d4a26": "9ac986f10ae7402bb3ac3d002fd0066e",
".git/objects/10/0b01c0a5517a3d576a921b7b1bcf9b7c2c0b2b": "6d050936be6a84eeb125f4dcbcbb5bc4",
".git/objects/12/14a8c6bafa2aa8121fa16b7aeb8b0d0e7fa23c": "0b35ed546db559ce1be47945d4761183",
".git/objects/12/39a6b2823cf203f4e9e495c760f7bb60d82605": "73ddb35715e07cdefbb4c56843164359",
".git/objects/12/593fe94af097ed0933334596c2a59377b41fc4": "91f0d237704712ac937eee92c88b5491",
".git/objects/1b/f5488f0e4679cf11257bd1f54988443012ef1a": "9f5c93fe6a1678949dd250c39ef2d613",
".git/objects/1f/d9535b5fdedb814158016a0f91850b5b5aef1b": "d6d2473a98fcbab6b1870e5a32a3720f",
".git/objects/22/e697123e9d758cafcf21fd711e96d57fd56d9e": "e8ce4a971de1a8fa887fe33259a64b19",
".git/objects/23/208cb93cd1f1fc6018ede17c1fc804017b8463": "abb0815abafa8773d55e9978b63f0b3a",
".git/objects/26/a6e1003eccd8ce2c3f0d205023b4cf3441b84a": "5fede2e724675b1b3f4e89f5044cf06a",
".git/objects/28/60a7203b9471251990d91dcfa30b1b95c3c7c6": "929fb63c7a6ff5f76a5ade4d19e7caf6",
".git/objects/29/6509e1e843a05300900250e8c07617057cf437": "86b245a8d433e8c7584381261daba2ff",
".git/objects/29/dba0c1beed65366696cea1ddeb1eb51892cf4f": "9b52b8fb59ff5740c9424923db739105",
".git/objects/29/dc4c1067aae8632fad9ce3d56420f388e822e6": "b55c45fcd45502a25cd56922a1614049",
".git/objects/2d/30f6e19aa5513f1fba6208d5f5d3091226bcdb": "f1e1404b9a76429d9110825fb3b4a5a4",
".git/objects/35/75e957c6894c7f2481c3b65352d80a46ac3c41": "8707d58d1f2aa0d769fa5ed941e69365",
".git/objects/3d/274bc778ffce498ba03f6b87ba1aa0bd4f99c9": "b454a6ee294913959e24f40d8c1d8f45",
".git/objects/48/dd701a6c35bf56df1d5cba88f063d11fb1400a": "b1021d0cbcf28a2c98005ab157cb84b9",
".git/objects/49/68a40674092127e00faa10540f5022e45430fc": "bd64fbf74a017ec48ae6b8e35bbaeb92",
".git/objects/4c/646fea27ac66d913bb2a98ebc73b13b550865f": "fb83fce0167542603f021d36fa200e6a",
".git/objects/4e/b63fd4de88cedfa788be6ea051e772da0244ca": "193b5a5798b18083ad3109bed9a8f716",
".git/objects/52/05695d1aff55dee0948caac15e2b12b06fc9da": "149628b785e8ba190f84c56acb936f9e",
".git/objects/57/05fc4b46f81309af8a6bb7065e0196bd125d6d": "6421d97a85d98979f8bf0679608621ea",
".git/objects/57/53bb88197b732cdda7f1d412f7b60875a737e7": "4cf9683885768c931b44ba135a2c409e",
".git/objects/59/4027ab85e93bd5189630ef4ec57ec2fea57d3c": "924aa3d0b75497414ea511fd9ebe10e4",
".git/objects/59/c9e65f446d11a7df98f3471f197859f64d31f8": "0bcb31f1c7967e524dfa366e4329ca87",
".git/objects/62/a1df7fde5b52c0e17b15207e2aaec6da30599a": "81eaf20144e39e214def187162cd8491",
".git/objects/62/a7c41b5e97b68f372f9ad52719a89c313bfc21": "67e5aef997adce22b29648f2c5ff72b0",
".git/objects/65/1276dfa88d6d5fc2d07140ed2015927c39f116": "f1b13e582e6f7c7349c7ac640a5d27ab",
".git/objects/67/4bfd7e115c43607fa6692189f94b4aa1234e38": "4d1f2c150184ae0df8751da402201d2c",
".git/objects/68/6dd9c0337bc2f8dba37da3a5c7ab7a2549cb23": "d055f2f402bd50a0b7b360b6be58fe0b",
".git/objects/6b/ffd1d5f991ae1d915e62c500f7c0a92c28ac2d": "735fdb0194ec78f665bc8a94b6d5f97c",
".git/objects/6c/727346f5e24fdb8041c548b89e40be7525a84c": "024bd6225ffd893129c94a621a9178ac",
".git/objects/6c/b3e68abdd2c97ba06c405e869a70e332bdfcd1": "5df657de437deb11b3f764c994621fee",
".git/objects/72/70e8fecf1763a5ab7504f25d7f2e882b541598": "89c9b04917ff69f9995f743b5617ea50",
".git/objects/72/b6b5b03a5d36465932ea697e931b66fd5031a0": "5b3b96e44c542aed2d1e228e440c9ece",
".git/objects/75/0787c9652e33b37b5b97c083c40ee42b92ffe3": "204ef6ed5aabac58682cbb0d585e5726",
".git/objects/76/52788375b6b9c36425a77b8e89c820d41dcb0e": "bf8008e74364b3b5abd1fd8783101098",
".git/objects/7e/49f02767ccdf3861de3a1ee4c1b05dca78da43": "101696796beeb211da2405f9d80e4fcb",
".git/objects/81/860f26e39e68c2af633816f56da14ba641e32d": "f4678a6b3b682a2bcc3c51a2bea85423",
".git/objects/82/7c164fc4cc743fb35d8f97b6089ae5edc1d9d9": "a1cb7fe4821caec6a7c20481dead0f1b",
".git/objects/83/0661f59453f88fc7c4eb78a035c0fa2268cb83": "8e3bd717a10cac7c905b816513ffa3a9",
".git/objects/83/b859dde20b90141745e36e98b54c7c22ac85f3": "c140bb83b720e28b7291e7661e3df415",
".git/objects/84/56c61a8662ab08d8b131b2bcf41b2ae046f8a6": "7d6c7fade08a53c44fe28c82e73dd66b",
".git/objects/88/6066844490721d8a3114e13b4b674d3bf1dcbe": "e289d07da61e67fa14f2358eae504b74",
".git/objects/88/9af8e798fb0407603a224465b310cc4ee56872": "450192d2a9c1eae0e777311a2a0270b7",
".git/objects/8e/f82eceacb4d509b9f47a5090672b6925651da3": "7e930cd771c9cebbabf5024554baa02f",
".git/objects/8f/1ade8df8e45b255a9ff71c355e811d1d31bc52": "cc13922a1142854e55e0a487409c4bee",
".git/objects/90/284f2b784978fe39f93e10f46b46546075f165": "9194031cdd74576fa631b96932929cdd",
".git/objects/93/8348ef7d4bb54ab78e0d0135928640ce655a40": "8652b509bc63a19d182ac14e587ef498",
".git/objects/94/dd4df57cbb01eb67a39f6dff59b600a6b48661": "3987c389da688e2e1518f3b9ce0c3ea7",
".git/objects/97/0d96e57b4a27c34b061516499c323bbeb84d2e": "8fed0233975d66fbc446a20011ab3a35",
".git/objects/97/cda8cc36ad2ff9884d3291edc300d2e4a0bd18": "fa3772f8887666e62a3946fcabc21197",
".git/objects/9b/fe789f98e088aad4d109d36b1a28e9a1cf21ad": "33b4fcabb5cd177567c56df47995ad64",
".git/objects/9c/84a2f3e57cb82513d48271565ef9a65edc2354": "03db2f4ab3b760210382e1b266b2c916",
".git/objects/a1/3d6e828c90c92ef76dd9f843c5b834e84624d2": "7db3ca9a2300a292bfa47df714eb8887",
".git/objects/a2/c2336cdf4fc47b160dceee1e284fa36068b9e1": "7763706691c1f8e847cf142e85a0ba5b",
".git/objects/a6/87e3c1e46172133eabf4761064fa0c717ef01c": "dc8e9c8498865b0685a77f027587d2af",
".git/objects/ad/6510a0c8c215a63e68b0c234b0c96f96d5978d": "2b2c7391b0ea9df94100f184076ce6a4",
".git/objects/ad/c31bbff5a018b23588b71790ec60a5970aeb06": "00c5e8f05c899f6c5279810caf8ced74",
".git/objects/af/30f68fe07921cc1b27f6b81df04917d2a5e7b8": "581209f616b09c45dcc68523ce8e0279",
".git/objects/b4/2d7fe14b85514c07df65f9d99f5149c9d0b604": "ecc2e349a9c41b2835e092d8bf978284",
".git/objects/b5/cbf852c816c468921a9fbe49dc8bdb97830115": "8db6019b819a81c077fa82801ca383bb",
".git/objects/b8/54ba88b836af5e0bb83e1deba23662a5665541": "c39901627470a9cbff6c086b180d1f2b",
".git/objects/c5/feadf234a651a611dd3ba1da9740b2fe363ccd": "bf510dbc68d354578d33eaabdb580db9",
".git/objects/c9/7e6b1513477f2d329422cb5426675156de8b42": "2485d36be0734bdf2cd9f6d9bdf39ff8",
".git/objects/cb/37f08d9e62132d25335ccd90ec0d313c33df3d": "b36441111c4b1da99e615ee8ca184c0f",
".git/objects/cc/418deb739a2d701dd5d87bf679f92e46f48a2d": "39d654877351d4ab90b28350c4145995",
".git/objects/cd/ebf0c32678eb8165d1d60dc1d74f221246e4d2": "02a8a3b5107ecf15772df1426a30f45a",
".git/objects/d5/8c8038da98b42c8b03031b77c58c68df0e4363": "a8896ff9e7b60294e12cd315a90e86ee",
".git/objects/d7/79145e003821a355c590a3744a957ab922e658": "d04d7afe00c5815ee21c633689b566c6",
".git/objects/d8/392e3a7e0c46562cf17247e3dd3049050f3be2": "bc2788bc8589a7f0cb6e1dcafef660a5",
".git/objects/da/030719d1e8a49dd60513d987f1bb87021c6a41": "c8428ee037e6fb133ff3c6c580713e02",
".git/objects/de/9405a9ca7439ae49ea3fa8b3dedc40071bdd46": "ef88997144c234a13ac71fcc95bc77ef",
".git/objects/de/a4a8ec651a0e1671b6f150f8596d183b5a6376": "253549e968e9d3c8b40ea1bbf66e346e",
".git/objects/de/c76adc96cf5806dae24e737c67b5475bedd561": "a6067a28e25cfc4d4302355b6b8f0975",
".git/objects/e2/99110a192bd7229709eb7015787c35305be898": "2b671e13a43c44edb72a7e1ed159f001",
".git/objects/e2/a15df1cc9bc9068bb06b7713f1934ed347a815": "8f901cbeb33d1b2afdc2ca556538a378",
".git/objects/e4/fa4562904e87f3d7c466011237bba656239825": "e8495e4888d02264106ad9ca80c32ba8",
".git/objects/e5/c7b7962ef9d72c4f6361dff30a0ad9ec1bf6d2": "753a6131e1aa0100ef2082423f9712f1",
".git/objects/e9/71a9a340f1e7ddb7013de93530f2b60f479584": "5856e5e182f58f6b010acd3ad4593b0a",
".git/objects/ea/3e45698bd8768788528cb149c21e032e2ffb08": "977fa5826f21484cdc59f9c23e679e4e",
".git/objects/ec/baf050db0d9c2533a2357bd5ca07846c003319": "2442fae44d394e7c3683ac821915d3f9",
".git/objects/ed/ce3c3cbf74f3125ab1349bb1d746558d33ef0d": "0ac6e839136e746e811ad74f70504f98",
".git/objects/ee/6c7066fbb52a94d09b2765b4dbe509c523621f": "5b8991c1c6f734278ccee1858a845cd4",
".git/objects/f2/0ec5f13a35ce6a2c03ce0ef6dbe24c60942861": "0cd76fbab8250d2f6b1347fbc77e78af",
".git/objects/f4/496335e7c594318a66f6e8077fc7ebf632cb17": "1dbc5986ea5269c6321eba5b7e660aec",
".git/objects/f4/6bada24ba5c2b160fd4c9dbb35407151c8fc27": "dd44e23beae704270c68c271f9f44a3d",
".git/objects/f8/8d1494da627b7a57052961eebc92a1ff67a4fe": "7090fbb147059a11db42f3fd3423a3ce",
".git/objects/fa/11f355820762595e589d52c12d34780d1dc363": "5b64604171e3947f43e46281ac143533",
".git/objects/fa/bfcad390a102bedc21d894c5e99c3ee17e4be0": "33a00c5423cea93c642433c9e7a9496b",
".git/objects/fa/c364728ddc70604e25a911758a52b312cfd01d": "5dec52e764ed4012c52b24dcf3ade05a",
".git/objects/fa/e6e03b4795cde5df255a48ebb3ba513901891a": "ceb34f304fab5701af9063492dd1965f",
".git/objects/ff/4faecda0fe1b9af41f6a6a7aa726057d75847e": "773cdcdf8b593e6b622445b999334657",
".git/objects/pack/pack-ac2d5fc35d3e96d779885f4ef5f4a9b357a59c9c.idx": "f53ba98e3cd7ffbae568ff630a771543",
".git/objects/pack/pack-ac2d5fc35d3e96d779885f4ef5f4a9b357a59c9c.pack": "92090ac310fe65b8469fb0aafaf3e408",
".git/ORIG_HEAD": "c7a7cdba3a45b6a5854ee3311d8efea2",
".git/packed-refs": "9d64b18ba67f3234a5de4050b42688ec",
".git/refs/heads/main": "c490aa4cdcb41439c6e12f47b5138da8",
".git/refs/remotes/origin/HEAD": "98b16e0b650190870f1b40bc8f4aec4e",
".git/refs/remotes/origin/main": "c490aa4cdcb41439c6e12f47b5138da8",
"assets/AssetManifest.bin": "d4af7f522784750dfd29a7b3c2b29db0",
"assets/AssetManifest.json": "18430a9315d79aacc913352ac8cb71d6",
"assets/assets/ar.json": "f0c8fafcc434080535602d9d8e90d1ce",
"assets/assets/en.json": "5dde6d246cf45af8006cf7b44ea1f83d",
"assets/assets/fonts/muli/Muli-Bold.ttf": "1e36ee6d50c037b1bb4bdd3effa7a28e",
"assets/assets/fonts/muli/Muli-ExtraLight.ttf": "7ba35f054cdef6104b5242202073a1f9",
"assets/assets/fonts/muli/Muli-Light.ttf": "6b667c3dbc3d4df6dd096ad18296704d",
"assets/assets/fonts/muli/Muli-SemiBold.ttf": "e74e966f227e49bb0f0d9cf3b8624064",
"assets/assets/fonts/muli/Muli.ttf": "df7330254513d2fa2f4c1e9ee98cc6c6",
"assets/assets/fonts/Tajawal/Tajawal-Bold.ttf": "76f83be859d749342ba420e1bb010d6a",
"assets/assets/fonts/Tajawal/Tajawal-ExtraBold.ttf": "066a37467c3af47d359507f7c7976071",
"assets/assets/fonts/Tajawal/Tajawal-ExtraLight.ttf": "cce1763b8395a41d57dfdf63a2e97e62",
"assets/assets/fonts/Tajawal/Tajawal-Light.ttf": "b6f8ed4fd29cc11d562ce730712aeaae",
"assets/assets/fonts/Tajawal/Tajawal-Medium.ttf": "3358032dd0994cf4a2116f0b16f80d70",
"assets/assets/icons/293411553_104223912364236_3184806906235607034_n.jpg": "06653e9025baa8b904af1f67bb389f38",
"assets/assets/icons/arrow_right.svg": "9c492cd795858f3522b4debfb737cbad",
"assets/assets/icons/Back%2520ICon.svg": "48c3c4eb319f67f90296649fa8271cce",
"assets/assets/icons/Bell.svg": "536eb6601a35ddab0f7b6bdd6c3ff145",
"assets/assets/icons/Bill%2520Icon.svg": "100acc86a48a094da8902a47f3bab1b6",
"assets/assets/icons/Call.svg": "3745eeef13c1facd87afe4cbe208e300",
"assets/assets/icons/Camera%2520Icon.svg": "6c417b2027ec9b901f856099422fc258",
"assets/assets/icons/Cart%2520Icon.svg": "b58f308b0312e4358a04eeadc02575d5",
"assets/assets/icons/Cash.svg": "a24a70772c290370387c0bb33730ce01",
"assets/assets/icons/Chat%2520bubble%2520Icon.svg": "997d4f0aa07c6094a4339040741b4bab",
"assets/assets/icons/Check%2520mark%2520rounde.svg": "e3ad560a09a1bf785b5505c21777ecee",
"assets/assets/icons/Close.svg": "6b3561c87a732bcdf1cfc4cefd9cd9f6",
"assets/assets/icons/Conversation.svg": "c23404da9004575ccff6f78b09be3b13",
"assets/assets/icons/Discover.svg": "b5e8150c8f0c20351b84b2241405c8b4",
"assets/assets/icons/down-arrow.png": "69de8d56a8845fcd5d6a0c65dc2b8c52",
"assets/assets/icons/Error.svg": "b69030d759140aaada89f2cc044a3c72",
"assets/assets/icons/facebook-2.svg": "b16d4798a9c0f65ff3a7b12270cd7f7d",
"assets/assets/icons/Flash%2520Icon.svg": "fcde0c03f2836567e42a45ac08616a42",
"assets/assets/icons/Game%2520Icon.svg": "116bd2707a410cf3a2e8559962e1c2a3",
"assets/assets/icons/Gift%2520Icon.svg": "d109169b3e2ab8256445f626ae4c888c",
"assets/assets/icons/google-icon.svg": "af89e162738e95f20e41f175cf1e930e",
"assets/assets/icons/Heart%2520Icon.svg": "0dcf36056268963f7b582eb3bd80ec72",
"assets/assets/icons/Heart%2520Icon_2.svg": "fd7dce0eb7741375843bcda4c7f4e52d",
"assets/assets/icons/icon.png": "fa20018856764c627f1ef63fad649dd9",
"assets/assets/icons/Location%2520point.svg": "5b1539e1fe1898b2155b6cc14b9f3c75",
"assets/assets/icons/Lock.svg": "ea577ace50978a6344c26a10c6f27b49",
"assets/assets/icons/Log%2520out.svg": "d762ccf53dc6843df2e7fa55ca08dba0",
"assets/assets/icons/Mail.svg": "deba8f9b4446c04abcf1cdca0590833a",
"assets/assets/icons/Parcel.svg": "17e6ca2305b1da7527281d69259c855a",
"assets/assets/icons/Phone.svg": "5fc702cf20c5fc37bd28a3bd5c8d8810",
"assets/assets/icons/pin_android.png": "feb25c6e7e40d5c19810dcf493ef2528",
"assets/assets/icons/pin_ios.png": "c27f0a45786778b300999268a2842209",
"assets/assets/icons/Plus%2520Icon.svg": "8980578e97cd2cbad00b71be8183f91d",
"assets/assets/icons/Question%2520mark.svg": "b20151b891eb8e9c927f259dabd6e553",
"assets/assets/icons/receipt.svg": "6dd6b67fb2796be43a9b9d2b1ee803de",
"assets/assets/icons/remove.svg": "a3a85cd7bc1699150a2c86e850a90e60",
"assets/assets/icons/Search%2520Icon.svg": "e86ce3fdf2c8be303b1338a287062d69",
"assets/assets/icons/Settings.svg": "d8e321d2db0af3ee55c643d20312ba8a",
"assets/assets/icons/Shop%2520Icon.svg": "71cf1a5022470cbbd1e76a923d1d968f",
"assets/assets/icons/sport-car.png": "7dae8131a7766105120596114bc03003",
"assets/assets/icons/Star%2520Icon.svg": "a4c930c4bf5854048edb32d7d370aada",
"assets/assets/icons/store_pin_android.png": "942a03d8f6b18aafa0217b7c4d9e6852",
"assets/assets/icons/store_pin_ios.png": "117cc238a2955108ded8ef77afbbbf1a",
"assets/assets/icons/Success.svg": "70f76d95e96ee6877ec6367b049fbc4d",
"assets/assets/icons/Trash.svg": "fe2725bc4781bace6708d522889456e7",
"assets/assets/icons/twitter.svg": "58e83cac5d93b6be707d27a9ffb5aa96",
"assets/assets/icons/unloaded.svg": "e4ab030e7a95ba5b074d34e7de91288f",
"assets/assets/icons/User%2520Icon.svg": "3944ad12a2e9014c192fc5795e69a589",
"assets/assets/icons/User.svg": "da6c4fccfbbf6a07d6478cb5ac7e9f9f",
"assets/assets/images/egypt.png": "008ed863b19c23aa9a26ffca719682d7",
"assets/assets/images/favicon.png": "17aa89473c315ab540a5c8b1300b217f",
"assets/assets/images/logo.png": "7eaf2ceb075ad92b4314d56d621b7e18",
"assets/assets/images/logo2.png": "6e9d650ba9e8dd5fe8d2b4f946fe2276",
"assets/assets/images/more.png": "cad7840cb104dcee30656e03fa9f4edf",
"assets/assets/images/more_outlined.png": "095d5cc1fe3726689d00f4d8f533d3cd",
"assets/assets/images/united-kingdom.png": "32c5e88fec8fd4fb489fce2e7be9d18c",
"assets/assets/map_style.json": "d3eeead2b2c8837e0965ea26d5c611d3",
"assets/FontManifest.json": "1da9fe68694f51ad7de9eba8d5a8defe",
"assets/fonts/MaterialIcons-Regular.otf": "a3e270e5428db326a8205b66764ce602",
"assets/NOTICES": "02956b6a578d964944d72d51cf945bdc",
"assets/packages/animated_snack_bar/assets/monochrome/check-circle.svg": "f6d9dd67711da5b6d4d965f66c10cd07",
"assets/packages/animated_snack_bar/assets/monochrome/comment-dots.svg": "44311bf381ea1155bfe38c40d44c577a",
"assets/packages/animated_snack_bar/assets/monochrome/exclamation-circle.svg": "63ffc503c8e024f9752866e021afb744",
"assets/packages/animated_snack_bar/assets/monochrome/exclamation-octagon.svg": "ab5fb6de2478b95f911cebb5cf6af9c3",
"assets/packages/animated_snack_bar/assets/monochrome/exclamation-triangle.svg": "10427de487dc532646c4a11f6be3fe84",
"assets/packages/animated_snack_bar/assets/regular/check-circle.svg": "0936541fbbf9ebf325169373c2d2439a",
"assets/packages/animated_snack_bar/assets/regular/exclamation-circle.svg": "69c777fe5b9ffd2f8286ca47f98d1a31",
"assets/packages/animated_snack_bar/assets/regular/exclamation-triangle.svg": "57a895d149648e4b69c7681d4efb2052",
"assets/packages/animated_snack_bar/assets/regular/info-circle.svg": "e733e8ecda8758e6b69d20cc1ca1c6c4",
"assets/packages/awesome_dialog/assets/flare/error.flr": "e3b124665e57682dab45f4ee8a16b3c9",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/packages/awesome_dialog/assets/flare/info2.flr": "21af33cb65751b76639d98e106835cfb",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/question.flr": "1c31ec57688a19de5899338f898290f0",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/rive/error.riv": "e74e21f8b53de4b541dd037c667027c1",
"assets/packages/awesome_dialog/assets/rive/info.riv": "2a425920b11404228f613bc51b30b2fb",
"assets/packages/awesome_dialog/assets/rive/info_reverse.riv": "c6e814d66c0e469f1574a2f171a13a76",
"assets/packages/awesome_dialog/assets/rive/question.riv": "00f02da4d08c2960079d4cd8211c930c",
"assets/packages/awesome_dialog/assets/rive/success.riv": "73618ab4166b406e130c2042dc595f42",
"assets/packages/awesome_dialog/assets/rive/warning.riv": "0becf971559a68f9a74c8f0c6e0f8335",
"assets/packages/country_code_picker/flags/ad.png": "796914c894c19b68adf1a85057378dbc",
"assets/packages/country_code_picker/flags/ae.png": "045eddd7da0ef9fb3a7593d7d2262659",
"assets/packages/country_code_picker/flags/af.png": "44bc280cbce3feb6ad13094636033999",
"assets/packages/country_code_picker/flags/ag.png": "9bae91983418f15d9b8ffda5ba340c4e",
"assets/packages/country_code_picker/flags/ai.png": "cfb0f715fc17e9d7c8662987fbe30867",
"assets/packages/country_code_picker/flags/al.png": "af06d6e1028d16ec472d94e9bf04d593",
"assets/packages/country_code_picker/flags/am.png": "2de892fa2f750d73118b1aafaf857884",
"assets/packages/country_code_picker/flags/an.png": "469f91bffae95b6ad7c299ac800ee19d",
"assets/packages/country_code_picker/flags/ao.png": "d19240c02a02e59c3c1ec0959f877f2e",
"assets/packages/country_code_picker/flags/aq.png": "c57c903b39fe5e2ba1e01bc3d330296c",
"assets/packages/country_code_picker/flags/ar.png": "bd71b7609d743ab9ecfb600e10ac7070",
"assets/packages/country_code_picker/flags/as.png": "830d17d172d2626e13bc6397befa74f3",
"assets/packages/country_code_picker/flags/at.png": "7edbeb0f5facb47054a894a5deb4533c",
"assets/packages/country_code_picker/flags/au.png": "600835121397ea512cea1f3204278329",
"assets/packages/country_code_picker/flags/aw.png": "8966dbf74a9f3fd342b8d08768e134cc",
"assets/packages/country_code_picker/flags/ax.png": "ffffd1de8a677dc02a47eb8f0e98d9ac",
"assets/packages/country_code_picker/flags/az.png": "967d8ee83bfe2f84234525feab9d1d4c",
"assets/packages/country_code_picker/flags/ba.png": "9faf88de03becfcd39b6231e79e51c2e",
"assets/packages/country_code_picker/flags/bb.png": "a5bb4503d41e97c08b2d4a9dd934fa30",
"assets/packages/country_code_picker/flags/bd.png": "5fbfa1a996e6da8ad4c5f09efc904798",
"assets/packages/country_code_picker/flags/be.png": "498270989eaefce71c393075c6e154c8",
"assets/packages/country_code_picker/flags/bf.png": "9b91173a8f8bb52b1eca2e97908f55dd",
"assets/packages/country_code_picker/flags/bg.png": "d591e9fa192837524f57db9ab2020a9e",
"assets/packages/country_code_picker/flags/bh.png": "6e48934b768705ca98a7d1e56422dc83",
"assets/packages/country_code_picker/flags/bi.png": "fb60b979ef7d78391bb32896af8b7021",
"assets/packages/country_code_picker/flags/bj.png": "9b503fbf4131f93fbe7b574b8c74357e",
"assets/packages/country_code_picker/flags/bl.png": "30f55fe505cb4f3ddc09a890d4073ebe",
"assets/packages/country_code_picker/flags/bm.png": "eb2492b804c9028f3822cdb1f83a48e2",
"assets/packages/country_code_picker/flags/bn.png": "94d863533155418d07a607b52ca1b701",
"assets/packages/country_code_picker/flags/bo.png": "92c247480f38f66397df4eb1f8ff0a68",
"assets/packages/country_code_picker/flags/bq.png": "67f4705e96d15041566913d30b00b127",
"assets/packages/country_code_picker/flags/br.png": "8fa9d6f8a64981d554e48f125c59c924",
"assets/packages/country_code_picker/flags/bs.png": "814a9a20dd15d78f555e8029795821f3",
"assets/packages/country_code_picker/flags/bt.png": "3c0fed3f67d5aa1132355ed76d2a14d0",
"assets/packages/country_code_picker/flags/bv.png": "f7f33a43528edcdbbe5f669b538bee2d",
"assets/packages/country_code_picker/flags/bw.png": "04fa1f47fc150e7e10938a2f497795be",
"assets/packages/country_code_picker/flags/by.png": "03f5334e6ab8a537d0fc03d76a4e0c8a",
"assets/packages/country_code_picker/flags/bz.png": "e95df47896e2a25df726c1dccf8af9ab",
"assets/packages/country_code_picker/flags/ca.png": "bc87852952310960507a2d2e590c92bf",
"assets/packages/country_code_picker/flags/cc.png": "126eedd79580be7279fec9bb78add64d",
"assets/packages/country_code_picker/flags/cd.png": "072243e38f84b5d2a7c39092fa883dda",
"assets/packages/country_code_picker/flags/cf.png": "625ad124ba8147122ee198ae5b9f061e",
"assets/packages/country_code_picker/flags/cg.png": "7ea7b458a77558527c030a5580b06779",
"assets/packages/country_code_picker/flags/ch.png": "8d7a211fd742d4dea9d1124672b88cda",
"assets/packages/country_code_picker/flags/ci.png": "0f94edf22f735b4455ac7597efb47ca5",
"assets/packages/country_code_picker/flags/ck.png": "35c6c878d96485422e28461bb46e7d9f",
"assets/packages/country_code_picker/flags/cl.png": "658cdc5c9fd73213495f1800ce1e2b78",
"assets/packages/country_code_picker/flags/cm.png": "89f02c01702cb245938f3d62db24f75d",
"assets/packages/country_code_picker/flags/cn.png": "6b8c353044ef5e29631279e0afc1a8c3",
"assets/packages/country_code_picker/flags/co.png": "e2fa18bb920565594a0e62427540163c",
"assets/packages/country_code_picker/flags/cr.png": "475b2d72352df176b722da898490afa2",
"assets/packages/country_code_picker/flags/cu.png": "8d4a05799ef3d6bbe07b241dd4398114",
"assets/packages/country_code_picker/flags/cv.png": "60d75c9d0e0cd186bb1b70375c797a0c",
"assets/packages/country_code_picker/flags/cw.png": "db36ed08bfafe9c5d0d02332597676ca",
"assets/packages/country_code_picker/flags/cx.png": "65421207e2eb319ba84617290bf24082",
"assets/packages/country_code_picker/flags/cy.png": "9a3518f15815fa1705f1d7ca18907748",
"assets/packages/country_code_picker/flags/cz.png": "482c8ba16ff3d81eeef60650db3802e4",
"assets/packages/country_code_picker/flags/de.png": "6f94b174f4a02f3292a521d992ed5193",
"assets/packages/country_code_picker/flags/dj.png": "dc144d9502e4edb3e392d67965f7583e",
"assets/packages/country_code_picker/flags/dk.png": "f9d6bcded318f5910b8bc49962730afa",
"assets/packages/country_code_picker/flags/dm.png": "b7ab53eeee4303e193ea1603f33b9c54",
"assets/packages/country_code_picker/flags/do.png": "a05514a849c002b2a30f420070eb0bbb",
"assets/packages/country_code_picker/flags/dz.png": "93afdc9291f99de3dd88b29be3873a20",
"assets/packages/country_code_picker/flags/ec.png": "cbaf1d60bbcde904a669030e1c883f3e",
"assets/packages/country_code_picker/flags/ee.png": "54aa1816507276a17070f395a4a89e2e",
"assets/packages/country_code_picker/flags/eg.png": "9e371179452499f2ba7b3c5ff47bec69",
"assets/packages/country_code_picker/flags/eh.png": "f781a34a88fa0adf175e3aad358575ed",
"assets/packages/country_code_picker/flags/er.png": "08a95adef16cb9174f183f8d7ac1102b",
"assets/packages/country_code_picker/flags/es.png": "e180e29212048d64951449cc80631440",
"assets/packages/country_code_picker/flags/et.png": "2c5eec0cda6655b5228fe0e9db763a8e",
"assets/packages/country_code_picker/flags/eu.png": "b32e3d089331f019b61399a1df5a763a",
"assets/packages/country_code_picker/flags/fi.png": "a79f2dbc126dac46e4396fcc80942a82",
"assets/packages/country_code_picker/flags/fj.png": "6030dc579525663142e3e8e04db80154",
"assets/packages/country_code_picker/flags/fk.png": "0e9d14f59e2e858cd0e89bdaec88c2c6",
"assets/packages/country_code_picker/flags/fm.png": "d4dffd237271ddd37f3bbde780a263bb",
"assets/packages/country_code_picker/flags/fo.png": "0bfc387f2eb3d9b85225d61b515ee8fc",
"assets/packages/country_code_picker/flags/fr.png": "79cbece941f09f9a9a46d42cabd523b1",
"assets/packages/country_code_picker/flags/ga.png": "fa05207326e695b552e0a885164ee5ac",
"assets/packages/country_code_picker/flags/gb-eng.png": "0b05e615c5a3feee707a4d72009cd767",
"assets/packages/country_code_picker/flags/gb-nir.png": "fc5305efe4f16b63fb507606789cc916",
"assets/packages/country_code_picker/flags/gb-sct.png": "075bb357733327ec4115ab5cbba792ac",
"assets/packages/country_code_picker/flags/gb-wls.png": "72005cb7be41ac749368a50a9d9f29ee",
"assets/packages/country_code_picker/flags/gb.png": "fc5305efe4f16b63fb507606789cc916",
"assets/packages/country_code_picker/flags/gd.png": "42ad178232488665870457dd53e2b037",
"assets/packages/country_code_picker/flags/ge.png": "93d6c82e9dc8440b706589d086be2c1c",
"assets/packages/country_code_picker/flags/gf.png": "71678ea3b4a8eeabd1e64a60eece4256",
"assets/packages/country_code_picker/flags/gg.png": "cdb11f97802d458cfa686f33459f0d4b",
"assets/packages/country_code_picker/flags/gh.png": "c73432df8a63fb674f93e8424eae545f",
"assets/packages/country_code_picker/flags/gi.png": "58894db0e25e9214ec2271d96d4d1623",
"assets/packages/country_code_picker/flags/gl.png": "d09f355715f608263cf0ceecd3c910ed",
"assets/packages/country_code_picker/flags/gm.png": "c670404188a37f5d347d03947f02e4d7",
"assets/packages/country_code_picker/flags/gn.png": "765a0434cb071ad4090a8ea06797a699",
"assets/packages/country_code_picker/flags/gp.png": "6cd39fe5669a38f6e33bffc7b697bab2",
"assets/packages/country_code_picker/flags/gq.png": "0dc3ca0cda7dfca81244e1571a4c466c",
"assets/packages/country_code_picker/flags/gr.png": "86aeb970a79aa561187fa8162aee2938",
"assets/packages/country_code_picker/flags/gs.png": "524d0f00ee874af0cdf3c00f49fa17ae",
"assets/packages/country_code_picker/flags/gt.png": "df7a020c2f611bdcb3fa8cd2f581b12f",
"assets/packages/country_code_picker/flags/gu.png": "babddec7750bad459ca1289d7ac7fc6a",
"assets/packages/country_code_picker/flags/gw.png": "25bc1b5542dadf2992b025695baf056c",
"assets/packages/country_code_picker/flags/gy.png": "75f8dd61ddedb3cf595075e64fc80432",
"assets/packages/country_code_picker/flags/hk.png": "51df04cf3db3aefd1778761c25a697dd",
"assets/packages/country_code_picker/flags/hm.png": "600835121397ea512cea1f3204278329",
"assets/packages/country_code_picker/flags/hn.png": "09ca9da67a9c84f4fc25f96746162f3c",
"assets/packages/country_code_picker/flags/hr.png": "04cfd167b9564faae3b2dd3ef13a0794",
"assets/packages/country_code_picker/flags/ht.png": "009d5c3627c89310bd25522b636b09bf",
"assets/packages/country_code_picker/flags/hu.png": "66c22db579470694c7928598f6643cc6",
"assets/packages/country_code_picker/flags/id.png": "78d94c7d31fed988e9b92279895d8b05",
"assets/packages/country_code_picker/flags/ie.png": "5790c74e53070646cd8a06eec43e25d6",
"assets/packages/country_code_picker/flags/il.png": "b72b572cc199bf03eba1c008cd00d3cb",
"assets/packages/country_code_picker/flags/im.png": "17ddc1376b22998731ccc5295ba9db1c",
"assets/packages/country_code_picker/flags/in.png": "be8bf440db707c1cc2ff9dd0328414e5",
"assets/packages/country_code_picker/flags/io.png": "8021829259b5030e95f45902d30f137c",
"assets/packages/country_code_picker/flags/iq.png": "dc9f3e8ab93b20c33f4a4852c162dc1e",
"assets/packages/country_code_picker/flags/ir.png": "df9b6d2134d1c5d4d3e676d9857eb675",
"assets/packages/country_code_picker/flags/is.png": "22358dadd1d5fc4f11fcb3c41d453ec0",
"assets/packages/country_code_picker/flags/it.png": "99f67d3c919c7338627d922f552c8794",
"assets/packages/country_code_picker/flags/je.png": "8d6482f71bd0728025134398fc7c6e58",
"assets/packages/country_code_picker/flags/jm.png": "3537217c5eeb048198415d398e0fa19e",
"assets/packages/country_code_picker/flags/jo.png": "d5bfa96801b7ed670ad1be55a7bd94ed",
"assets/packages/country_code_picker/flags/jp.png": "b7a724413be9c2b001112c665d764385",
"assets/packages/country_code_picker/flags/ke.png": "034164976de81ef96f47cfc6f708dde6",
"assets/packages/country_code_picker/flags/kg.png": "a9b6a1b8fe03b8b617f30a28a1d61c12",
"assets/packages/country_code_picker/flags/kh.png": "cd50a67c3b8058585b19a915e3635107",
"assets/packages/country_code_picker/flags/ki.png": "69a7d5a8f6f622e6d2243f3f04d1d4c0",
"assets/packages/country_code_picker/flags/km.png": "204a44c4c89449415168f8f77c4c0d31",
"assets/packages/country_code_picker/flags/kn.png": "65d2fc69949162f1bc14eb9f2da5ecbc",
"assets/packages/country_code_picker/flags/kp.png": "fd6e44b3fe460988afbfd0cb456282b2",
"assets/packages/country_code_picker/flags/kr.png": "9e2a9c7ae07cf8977e8f01200ee2912e",
"assets/packages/country_code_picker/flags/kw.png": "b2afbb748e0b7c0b0c22f53e11e7dd55",
"assets/packages/country_code_picker/flags/ky.png": "666d01aa03ecdf6b96202cdf6b08b732",
"assets/packages/country_code_picker/flags/kz.png": "cfce5cd7842ef8091b7c25b23c3bb069",
"assets/packages/country_code_picker/flags/la.png": "8c88d02c3824eea33af66723d41bb144",
"assets/packages/country_code_picker/flags/lb.png": "b21c8d6f5dd33761983c073f217a0c4f",
"assets/packages/country_code_picker/flags/lc.png": "055c35de209c63b67707c5297ac5079a",
"assets/packages/country_code_picker/flags/li.png": "3cf7e27712e36f277ca79120c447e5d1",
"assets/packages/country_code_picker/flags/lk.png": "56412c68b1d952486f2da6c1318adaf2",
"assets/packages/country_code_picker/flags/lr.png": "1c159507670497f25537ad6f6d64f88d",
"assets/packages/country_code_picker/flags/ls.png": "f2d4025bf560580ab141810a83249df0",
"assets/packages/country_code_picker/flags/lt.png": "e38382f3f7cb60cdccbf381cea594d2d",
"assets/packages/country_code_picker/flags/lu.png": "4cc30d7a4c3c3b98f55824487137680d",
"assets/packages/country_code_picker/flags/lv.png": "6a86b0357df4c815f1dc21e0628aeb5f",
"assets/packages/country_code_picker/flags/ly.png": "777f861e476f1426bf6663fa283243e5",
"assets/packages/country_code_picker/flags/ma.png": "dd5dc19e011755a7610c1e7ccd8abdae",
"assets/packages/country_code_picker/flags/mc.png": "412ce0b1f821e3912e83ae356b30052e",
"assets/packages/country_code_picker/flags/md.png": "7b273f5526b88ed0d632fd0fd8be63be",
"assets/packages/country_code_picker/flags/me.png": "74434a1447106cc4fb7556c76349c3da",
"assets/packages/country_code_picker/flags/mf.png": "6cd39fe5669a38f6e33bffc7b697bab2",
"assets/packages/country_code_picker/flags/mg.png": "a562a819338427e57c57744bb92b1ef1",
"assets/packages/country_code_picker/flags/mh.png": "2a7c77b8b1b4242c6aa8539babe127a7",
"assets/packages/country_code_picker/flags/mk.png": "8b17ec36efa149749b8d3fd59f55974b",
"assets/packages/country_code_picker/flags/ml.png": "1a3a39e5c9f2fdccfb6189a117d04f72",
"assets/packages/country_code_picker/flags/mm.png": "b664dc1c591c3bf34ad4fd223922a439",
"assets/packages/country_code_picker/flags/mn.png": "02af8519f83d06a69068c4c0f6463c8a",
"assets/packages/country_code_picker/flags/mo.png": "da3700f98c1fe1739505297d1efb9e12",
"assets/packages/country_code_picker/flags/mp.png": "60b14b06d1ce23761767b73d54ef613a",
"assets/packages/country_code_picker/flags/mq.png": "446edd9300307eda562e5c9ac307d7f2",
"assets/packages/country_code_picker/flags/mr.png": "733d747ba4ec8cf120d5ebc0852de34a",
"assets/packages/country_code_picker/flags/ms.png": "32daa6ee99335b73cb3c7519cfd14a61",
"assets/packages/country_code_picker/flags/mt.png": "808538b29f6b248469a184bbf787a97f",
"assets/packages/country_code_picker/flags/mu.png": "aec293ef26a9df356ea2f034927b0a74",
"assets/packages/country_code_picker/flags/mv.png": "69843b1ad17352372e70588b9c37c7cc",
"assets/packages/country_code_picker/flags/mw.png": "efc0c58b76be4bf1c3efda589b838132",
"assets/packages/country_code_picker/flags/mx.png": "b69db8e7f14b18ddd0e3769f28137552",
"assets/packages/country_code_picker/flags/my.png": "7b4bc8cdef4f7b237791c01f5e7874f4",
"assets/packages/country_code_picker/flags/mz.png": "40a78c6fa368aed11b3d483cdd6973a5",
"assets/packages/country_code_picker/flags/na.png": "3499146c4205c019196f8a0f7a7aa156",
"assets/packages/country_code_picker/flags/nc.png": "a3ee8fc05db66f7ce64bce533441da7f",
"assets/packages/country_code_picker/flags/ne.png": "a152defcfb049fa960c29098c08e3cd3",
"assets/packages/country_code_picker/flags/nf.png": "9a4a607db5bc122ff071cbfe58040cf7",
"assets/packages/country_code_picker/flags/ng.png": "15b7ad41c03c87b9f30c19d37f457817",
"assets/packages/country_code_picker/flags/ni.png": "6985ed1381cb33a5390258795f72e95a",
"assets/packages/country_code_picker/flags/nl.png": "67f4705e96d15041566913d30b00b127",
"assets/packages/country_code_picker/flags/no.png": "f7f33a43528edcdbbe5f669b538bee2d",
"assets/packages/country_code_picker/flags/np.png": "35e3d64e59650e1f1cf909f5c6d85176",
"assets/packages/country_code_picker/flags/nr.png": "f5ae3c51dfacfd6719202b4b24e20131",
"assets/packages/country_code_picker/flags/nu.png": "c8bb4da14b8ffb703036b1bae542616d",
"assets/packages/country_code_picker/flags/nz.png": "b48a5e047a5868e59c2abcbd8387082d",
"assets/packages/country_code_picker/flags/om.png": "79a867771bd9447d372d5df5ec966b36",
"assets/packages/country_code_picker/flags/pa.png": "49d53d64564555ea5976c20ea9365ea6",
"assets/packages/country_code_picker/flags/pe.png": "724d3525f205dfc8705bb6e66dd5bdff",
"assets/packages/country_code_picker/flags/pf.png": "3ba7f48f96a7189f9511a7f77ea0a7a4",
"assets/packages/country_code_picker/flags/pg.png": "06961c2b216061b0e40cb4221abc2bff",
"assets/packages/country_code_picker/flags/ph.png": "de75e3931c41ae8b9cae8823a9500ca7",
"assets/packages/country_code_picker/flags/pk.png": "0228ceefa355b34e8ec3be8bfd1ddb42",
"assets/packages/country_code_picker/flags/pl.png": "a7b46e3dcd5571d40c3fa8b62b1f334a",
"assets/packages/country_code_picker/flags/pm.png": "6cd39fe5669a38f6e33bffc7b697bab2",
"assets/packages/country_code_picker/flags/pn.png": "ffa91e8a1df1eac6b36d737aa76d701b",
"assets/packages/country_code_picker/flags/pr.png": "ac1c4bcef3da2034e1668ab1e95ae82d",
"assets/packages/country_code_picker/flags/ps.png": "b6e1bd808cf8e5e3cd2b23e9cf98d12e",
"assets/packages/country_code_picker/flags/pt.png": "b4cf39fbafb4930dec94f416e71fc232",
"assets/packages/country_code_picker/flags/pw.png": "92ec1edf965de757bc3cca816f4cebbd",
"assets/packages/country_code_picker/flags/py.png": "6bb880f2dd24622093ac59d4959ae70d",
"assets/packages/country_code_picker/flags/qa.png": "b95e814a13e5960e28042347cec5bc0d",
"assets/packages/country_code_picker/flags/re.png": "6cd39fe5669a38f6e33bffc7b697bab2",
"assets/packages/country_code_picker/flags/ro.png": "1ee3ca39dbe79f78d7fa903e65161fdb",
"assets/packages/country_code_picker/flags/rs.png": "ee9ae3b80531d6d0352a39a56c5130c0",
"assets/packages/country_code_picker/flags/ru.png": "9a3b50fcf2f7ae2c33aa48b91ab6cd85",
"assets/packages/country_code_picker/flags/rw.png": "6ef05d29d0cded56482b1ad17f49e186",
"assets/packages/country_code_picker/flags/sa.png": "ef836bd02f745af03aa0d01003942d44",
"assets/packages/country_code_picker/flags/sb.png": "e3a6704b7ba2621480d7074a6e359b03",
"assets/packages/country_code_picker/flags/sc.png": "52f9bd111531041468c89ce9da951026",
"assets/packages/country_code_picker/flags/sd.png": "93e252f26bead630c0a0870de5a88f14",
"assets/packages/country_code_picker/flags/se.png": "24d2bed25b5aad316134039c2903ac59",
"assets/packages/country_code_picker/flags/sg.png": "94ea82acf1aa0ea96f58c6b0cd1ed452",
"assets/packages/country_code_picker/flags/sh.png": "fc5305efe4f16b63fb507606789cc916",
"assets/packages/country_code_picker/flags/si.png": "922d047a95387277f84fdc246f0a8d11",
"assets/packages/country_code_picker/flags/sj.png": "f7f33a43528edcdbbe5f669b538bee2d",
"assets/packages/country_code_picker/flags/sk.png": "0f8da623c8f140ac2b5a61234dd3e7cd",
"assets/packages/country_code_picker/flags/sl.png": "a7785c2c81149afab11a5fa86ee0edae",
"assets/packages/country_code_picker/flags/sm.png": "b41d5b7eb3679c2e477fbd25f5ee9e7d",
"assets/packages/country_code_picker/flags/sn.png": "25201e1833a1b642c66c52a09b43f71e",
"assets/packages/country_code_picker/flags/so.png": "cfe6bb95bcd259a3cc41a09ee7ca568b",
"assets/packages/country_code_picker/flags/sr.png": "e5719b1a8ded4e5230f6bac3efc74a90",
"assets/packages/country_code_picker/flags/ss.png": "f1c99aded110fc8a0bc85cd6c63895fb",
"assets/packages/country_code_picker/flags/st.png": "7a28a4f0333bf4fb4f34b68e65c04637",
"assets/packages/country_code_picker/flags/sv.png": "994c8315ced2a4d8c728010447371ea1",
"assets/packages/country_code_picker/flags/sx.png": "8fce7986b531ff8936540ad1155a5df5",
"assets/packages/country_code_picker/flags/sy.png": "2e33ad23bffc935e4a06128bc5519a2b",
"assets/packages/country_code_picker/flags/sz.png": "5e45a755ac4b33df811f0fb76585270e",
"assets/packages/country_code_picker/flags/tc.png": "6f2d1a2b9f887be4b3568169e297a506",
"assets/packages/country_code_picker/flags/td.png": "51b129223db46adc71f9df00c93c2868",
"assets/packages/country_code_picker/flags/tf.png": "dc3f8c0d9127aa82cbd45b8861a67bf5",
"assets/packages/country_code_picker/flags/tg.png": "82dabd3a1a4900ae4866a4da65f373e5",
"assets/packages/country_code_picker/flags/th.png": "d4bd67d33ed4ac74b4e9b75d853dae02",
"assets/packages/country_code_picker/flags/tj.png": "2407ba3e581ffd6c2c6b28e9692f9e39",
"assets/packages/country_code_picker/flags/tk.png": "87e390b384b39af41afd489e42b03e07",
"assets/packages/country_code_picker/flags/tl.png": "b3475faa9840f875e5ec38b0e6a6c170",
"assets/packages/country_code_picker/flags/tm.png": "3fe5e44793aad4e8997c175bc72fda06",
"assets/packages/country_code_picker/flags/tn.png": "87f591537e0a5f01bb10fe941798d4e4",
"assets/packages/country_code_picker/flags/to.png": "a93fdd2ace7777e70528936a135f1610",
"assets/packages/country_code_picker/flags/tr.png": "0100620dedad6034185d0d53f80287bd",
"assets/packages/country_code_picker/flags/tt.png": "716fa6f4728a25ffccaf3770f5f05f7b",
"assets/packages/country_code_picker/flags/tv.png": "493c543f07de75f222d8a76506c57989",
"assets/packages/country_code_picker/flags/tw.png": "94322a94d308c89d1bc7146e05f1d3e5",
"assets/packages/country_code_picker/flags/tz.png": "389451347d28584d88b199f0cbe0116b",
"assets/packages/country_code_picker/flags/ua.png": "dbd97cfa852ffc84bfdf98bc2a2c3789",
"assets/packages/country_code_picker/flags/ug.png": "6ae26af3162e5e3408cb5c5e1c968047",
"assets/packages/country_code_picker/flags/um.png": "b1cb710eb57a54bc3eea8e4fba79b2c1",
"assets/packages/country_code_picker/flags/us.png": "b1cb710eb57a54bc3eea8e4fba79b2c1",
"assets/packages/country_code_picker/flags/uy.png": "20c63ac48df3e394fa242d430276a988",
"assets/packages/country_code_picker/flags/uz.png": "d3713ea19c37aaf94975c3354edd7bb7",
"assets/packages/country_code_picker/flags/va.png": "cfbf48f8fcaded75f186d10e9d1408fd",
"assets/packages/country_code_picker/flags/vc.png": "a604d5acd8c7be6a2bbaa1759ac2949d",
"assets/packages/country_code_picker/flags/ve.png": "f5dabf05e3a70b4eeffa5dad32d10a67",
"assets/packages/country_code_picker/flags/vg.png": "0f19ce4f3c92b0917902cb316be492ba",
"assets/packages/country_code_picker/flags/vi.png": "944281795d5daf17a273f394e51b8b79",
"assets/packages/country_code_picker/flags/vn.png": "7c8f8457485f14482dcab4042e432e87",
"assets/packages/country_code_picker/flags/vu.png": "1bed31828f3b7e0ff260f61ab45396ad",
"assets/packages/country_code_picker/flags/wf.png": "4d33c71f87a33e47a0e466191c4eb3db",
"assets/packages/country_code_picker/flags/ws.png": "8cef2c9761d3c8107145d038bf1417ea",
"assets/packages/country_code_picker/flags/xk.png": "b75ba9ad218b109fca4ef1f3030936f1",
"assets/packages/country_code_picker/flags/ye.png": "1d5dcbcbbc8de944c3db228f0c089569",
"assets/packages/country_code_picker/flags/yt.png": "6cd39fe5669a38f6e33bffc7b697bab2",
"assets/packages/country_code_picker/flags/za.png": "aa749828e6cf1a3393e0d5c9ab088af0",
"assets/packages/country_code_picker/flags/zm.png": "29b67848f5e3864213c84ccf108108ea",
"assets/packages/country_code_picker/flags/zw.png": "d5c4fe9318ebc1a68e3445617215195f",
"assets/packages/country_code_picker/src/i18n/af.json": "56c2bccb2affb253d9f275496b594453",
"assets/packages/country_code_picker/src/i18n/am.json": "d32ed11596bd0714c9fce1f1bfc3f16e",
"assets/packages/country_code_picker/src/i18n/ar.json": "fcc06d7c93de78066b89f0030cdc5fe3",
"assets/packages/country_code_picker/src/i18n/az.json": "430fd5cb15ab8126b9870261225c4032",
"assets/packages/country_code_picker/src/i18n/be.json": "b3ded71bde8fbbdac0bf9c53b3f66fff",
"assets/packages/country_code_picker/src/i18n/bg.json": "fc2f396a23bf35047919002a68cc544c",
"assets/packages/country_code_picker/src/i18n/bn.json": "1d49af56e39dea0cf602c0c22046d24c",
"assets/packages/country_code_picker/src/i18n/bs.json": "8fa362bc16f28b5ca0e05e82536d9bd9",
"assets/packages/country_code_picker/src/i18n/ca.json": "cdf37aa8bb59b485e9b566bff8523059",
"assets/packages/country_code_picker/src/i18n/cs.json": "7cb74ecb8d6696ba6f333ae1cfae59eb",
"assets/packages/country_code_picker/src/i18n/da.json": "bb4a77f6bfaf82e4ed0b57ec41e289aa",
"assets/packages/country_code_picker/src/i18n/de.json": "a56eb56282590b138102ff72d64420f4",
"assets/packages/country_code_picker/src/i18n/el.json": "e4da1a5d8ab9c6418036307d54a9aa16",
"assets/packages/country_code_picker/src/i18n/en.json": "759bf8bef6af283a25d7a2204bdf3d78",
"assets/packages/country_code_picker/src/i18n/es.json": "c9f37c216b3cead47636b86c1b383d20",
"assets/packages/country_code_picker/src/i18n/et.json": "a5d4f54704d2cdabb368760399d3cae5",
"assets/packages/country_code_picker/src/i18n/fa.json": "baefec44af8cd45714204adbc6be15cb",
"assets/packages/country_code_picker/src/i18n/fi.json": "3ad6c7d3efbb4b1041d087a0ef4a70b9",
"assets/packages/country_code_picker/src/i18n/fr.json": "b9be4d0a12f9d7c3b8fcf6ce41facd0b",
"assets/packages/country_code_picker/src/i18n/gl.json": "14e84ea53fe4e3cef19ee3ad2dff3967",
"assets/packages/country_code_picker/src/i18n/ha.json": "4d0c8114bf4e4fd1e68d71ff3af6528f",
"assets/packages/country_code_picker/src/i18n/he.json": "6f7a03d60b73a8c5f574188370859d12",
"assets/packages/country_code_picker/src/i18n/hi.json": "3dac80dc00dc7c73c498a1de439840b4",
"assets/packages/country_code_picker/src/i18n/hr.json": "e7a48f3455a0d27c0fa55fa9cbf02095",
"assets/packages/country_code_picker/src/i18n/hu.json": "3cd9c2280221102780d44b3565db7784",
"assets/packages/country_code_picker/src/i18n/hy.json": "1e2f6d1808d039d7db0e7e335f1a7c77",
"assets/packages/country_code_picker/src/i18n/id.json": "e472d1d00471f86800572e85c3f3d447",
"assets/packages/country_code_picker/src/i18n/is.json": "6cf088d727cd0db23f935be9f20456bb",
"assets/packages/country_code_picker/src/i18n/it.json": "c1f0d5c4e81605566fcb7f399d800768",
"assets/packages/country_code_picker/src/i18n/ja.json": "3f709dc6a477636eff4bfde1bd2d55e1",
"assets/packages/country_code_picker/src/i18n/ka.json": "23c8b2028efe71dab58f3cee32eada43",
"assets/packages/country_code_picker/src/i18n/kk.json": "bca3f77a658313bbe950fbc9be504fac",
"assets/packages/country_code_picker/src/i18n/km.json": "19fedcf05e4fd3dd117d24e24b498937",
"assets/packages/country_code_picker/src/i18n/ko.json": "76484ad0eb25412d4c9be010bca5baf0",
"assets/packages/country_code_picker/src/i18n/ku.json": "4c743e7dd3d124cb83602d20205d887c",
"assets/packages/country_code_picker/src/i18n/ky.json": "51dff3d9ff6de3775bc0ffeefe6d36cb",
"assets/packages/country_code_picker/src/i18n/lt.json": "21cacbfa0a4988d180feb3f6a2326660",
"assets/packages/country_code_picker/src/i18n/lv.json": "1c83c9664e00dce79faeeec714729a26",
"assets/packages/country_code_picker/src/i18n/mk.json": "899e90341af48b31ffc8454325b454b2",
"assets/packages/country_code_picker/src/i18n/ml.json": "096da4f99b9bd77d3fe81dfdc52f279f",
"assets/packages/country_code_picker/src/i18n/mn.json": "6f69ca7a6a08753da82cb8437f39e9a9",
"assets/packages/country_code_picker/src/i18n/ms.json": "826babac24d0d842981eb4d5b2249ad6",
"assets/packages/country_code_picker/src/i18n/nb.json": "c0f89428782cd8f5ab172621a00be3d0",
"assets/packages/country_code_picker/src/i18n/nl.json": "20d4bf89d3aa323f7eb448a501f487e1",
"assets/packages/country_code_picker/src/i18n/nn.json": "129e66510d6bcb8b24b2974719e9f395",
"assets/packages/country_code_picker/src/i18n/no.json": "7a5ef724172bd1d2515ac5d7b0a87366",
"assets/packages/country_code_picker/src/i18n/pl.json": "78cbb04b3c9e7d27b846ee6a5a82a77b",
"assets/packages/country_code_picker/src/i18n/ps.json": "ab8348fd97d6ceddc4a509e330433caa",
"assets/packages/country_code_picker/src/i18n/pt.json": "bd7829884fd97de8243cba4257ab79b2",
"assets/packages/country_code_picker/src/i18n/ro.json": "c38a38f06203156fbd31de4daa4f710a",
"assets/packages/country_code_picker/src/i18n/ru.json": "aaf6b2672ef507944e74296ea719f3b2",
"assets/packages/country_code_picker/src/i18n/sd.json": "281e13e4ec4df824094e1e64f2d185a7",
"assets/packages/country_code_picker/src/i18n/sk.json": "3c52ed27adaaf54602fba85158686d5a",
"assets/packages/country_code_picker/src/i18n/sl.json": "4a88461ce43941d4a52594a65414e98f",
"assets/packages/country_code_picker/src/i18n/so.json": "09e1f045e22b85a7f54dd2edc446b0e8",
"assets/packages/country_code_picker/src/i18n/sq.json": "0aa6432ab040153355d88895aa48a72f",
"assets/packages/country_code_picker/src/i18n/sr.json": "69a10a0b63edb61e01bc1ba7ba6822e4",
"assets/packages/country_code_picker/src/i18n/sv.json": "7a6a6a8a91ca86bb0b9e7f276d505896",
"assets/packages/country_code_picker/src/i18n/ta.json": "48b6617bde902cf72e0ff1731fadfd07",
"assets/packages/country_code_picker/src/i18n/tg.json": "5512d16cb77eb6ba335c60b16a22578b",
"assets/packages/country_code_picker/src/i18n/th.json": "721b2e8e586eb7c7da63a18b5aa3a810",
"assets/packages/country_code_picker/src/i18n/tr.json": "d682217c3ccdd9cc270596fe1af7a182",
"assets/packages/country_code_picker/src/i18n/tt.json": "e3687dceb189c2f6600137308a11b22f",
"assets/packages/country_code_picker/src/i18n/ug.json": "e2be27143deb176fa325ab9b229d8fd8",
"assets/packages/country_code_picker/src/i18n/uk.json": "a7069f447eb0060aa387a649e062c895",
"assets/packages/country_code_picker/src/i18n/ur.json": "b5bc6921e006ae9292ed09e0eb902716",
"assets/packages/country_code_picker/src/i18n/uz.json": "00e22e3eb3a7198f0218780f2b04369c",
"assets/packages/country_code_picker/src/i18n/vi.json": "fa3d9a3c9c0d0a20d0bd5e6ac1e97835",
"assets/packages/country_code_picker/src/i18n/zh.json": "44a9040959b2049350bbff0696b84d45",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d7791ef376c159f302b8ad90a748d2ab",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5070443340d1d8cceb516d02c3d6dee7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "658b490c9da97710b01bd0f8825fce94",
"assets/packages/localization/test/assets/lang/en_US.json": "18804652fbce3b62aacb6cce6f572f3c",
"assets/packages/localization/test/assets/lang/pt_BR.json": "f999b93065fe17d355d1ac5dcc1ff830",
"assets/packages/localization/test/assets/lang2/en_US.json": "b389499c34b7ee2ec98c62fe49e08fa0",
"assets/packages/localization/test/assets/lang2/pt_BR.json": "08e9b784a138126822761beec7614524",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"CNAME": "a79b2c3f00aa8382c084dff6a88fdfd8",
"favicon.png": "17aa89473c315ab540a5c8b1300b217f",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "356055cecf919f61e8c5a7df073f1ab2",
"icons/Icon-512.png": "cf5894ed69976fcf97237a8bcfdc08f2",
"icons/Icon-maskable-192.png": "356055cecf919f61e8c5a7df073f1ab2",
"icons/Icon-maskable-512.png": "cf5894ed69976fcf97237a8bcfdc08f2",
"index.html": "036e1daacbc4941b8d2798fb610f12fb",
"/": "036e1daacbc4941b8d2798fb610f12fb",
"main.dart.js": "c519027fd201e1c9ce02e247ef1df44d",
"main.dart.js_1.part.js": "fe9f57348b151a3539ebb7ce421437c9",
"main.dart.js_10.part.js": "fd32bf5b8362e1107afe5a31203674f8",
"main.dart.js_11.part.js": "cfa675d888202ff406dd7c4b66ec75ae",
"main.dart.js_12.part.js": "a99930984feda269bbd27d9eb56e8899",
"main.dart.js_13.part.js": "ad7792a15f18993b0775b616b5eaf454",
"main.dart.js_14.part.js": "ab8e40222792618cb642447ea5ed0221",
"main.dart.js_15.part.js": "ecb62c8b2da423cbd37cbb09341f7526",
"main.dart.js_17.part.js": "a1622a155f9dbb6a28e1e2ebf324dc33",
"main.dart.js_18.part.js": "227956140da88723b95282a00603f35c",
"main.dart.js_2.part.js": "efbe42620ff271547cbd201818cd1e27",
"main.dart.js_20.part.js": "3c8d4b79c48b740903abe69651cb2453",
"main.dart.js_21.part.js": "37bb94b91d0043c82129211bdca76d41",
"main.dart.js_22.part.js": "4ffaf6c33d2d8866dd495baedfedade6",
"main.dart.js_23.part.js": "6f170c07da3ac40122fbc3b1b73c99b6",
"main.dart.js_24.part.js": "7ee73566032b0d4edfc8ebafbae02ac3",
"main.dart.js_25.part.js": "9e4f03e4495749b186fb9c681b9cef22",
"main.dart.js_26.part.js": "5fc26a38e363df0338bd0bb10d1a6723",
"main.dart.js_27.part.js": "78cdca754d93efd571b2db7b9845f75b",
"main.dart.js_28.part.js": "eb5e4ac44fbb35bf0d982d4a2af81445",
"main.dart.js_29.part.js": "b2c691d1ef27f3316507055a2ce48b84",
"main.dart.js_3.part.js": "657ac8b7c5bb31bb7725ef300f3077e4",
"main.dart.js_30.part.js": "64f389c78df8882969ac812bc9e08634",
"main.dart.js_31.part.js": "c1274d3bdf3008e158e7624c639db8db",
"main.dart.js_32.part.js": "c9d877abcba0096daa22ae833e7a02b0",
"main.dart.js_33.part.js": "299c8b0ec134c38ad02afce494fc6c38",
"main.dart.js_34.part.js": "b51c3a4013a09640a5a12723edc8a200",
"main.dart.js_35.part.js": "622fa69cd9ab05d9374137e75b12601d",
"main.dart.js_36.part.js": "88306501ef0443149f394babf02ce0a9",
"main.dart.js_37.part.js": "5075bdb1810318ab812bc05629da155a",
"main.dart.js_38.part.js": "e0b95cba478edb3453af5964d8a564f6",
"main.dart.js_39.part.js": "08395eb17c33d3477d21064ae3d673e2",
"main.dart.js_4.part.js": "ec1cb71dac76c1dc458c20f4e014cc40",
"main.dart.js_5.part.js": "5867c4dcd3c26d24d85a72d38c21de29",
"main.dart.js_6.part.js": "4f8664dac8da9a6f9c9b0414cc8b5713",
"main.dart.js_7.part.js": "b659ae6a9260427b91e7b63669068378",
"main.dart.js_8.part.js": "331a398f293921bf0ae3e78471691d05",
"main.dart.js_9.part.js": "1b35a66893ff5c463af31185ae9ddf0e",
"manifest.json": "967997ddcdf06ee6e37d407fbc50e2a9",
"version.json": "23385d2acaba4a30dc7f06068ecb3218"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
