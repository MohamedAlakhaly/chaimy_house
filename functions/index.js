const { onCall, HttpsError } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");

if (admin.apps.length === 0) {
    admin.initializeApp();
}

exports.deleteUserByAdmin = onCall(async (request) => {
    // 1. التحقق من صلاحية الشخص الذي يطلب الحذف
    // إذا كنت تريد التأكد من أن المستدعي مسجل دخول
    if (!request.auth) {
        throw new HttpsError("unauthenticated", "يجب تسجيل الدخول أولاً");
    }

    const uidToDelete = request.data.uid;

    // التأكد من إرسال الـ UID
    if (!uidToDelete) {
        throw new HttpsError("invalid-argument", "لم يتم توفير UID للمستخدم المطلوب حذفه");
    }

    try {
        // 2. حذف المستخدم من Firebase Auth
        await admin.auth().deleteUser(uidToDelete);

        // 3. حذف بيانات المستخدم من Firestore (مجموعة users)
        await admin.firestore().collection("users").doc(uidToDelete).delete();

        return { 
            status: "success", 
            message: `تم حذف المستخدم ${uidToDelete} بنجاح` 
        };
    } catch (error) {
        console.error("خطأ أثناء الحذف:", error);
        throw new HttpsError("internal", "حدث خطأ داخلي: " + error.message);
    }
});