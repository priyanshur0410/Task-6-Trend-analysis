# 📊 Sales Trend Analysis with SQL

यह प्रोजेक्ट SQL का उपयोग करके महीने-दर-महीने बिक्री ट्रेंड (रेवेन्यू और ऑर्डर वॉल्यूम) का विश्लेषण करता है।

## 🛠 Tools Used
- **Database**: PostgreSQL / MySQL / SQLite
- **Dataset**: `orders` टेबल (`order_id`, `order_date`, `amount`, `product_id`)

## 📂 Dataset Structure
टेबल स्कीमा:
```sql
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT



);



📚 Key Concepts
GROUP BY: डेटा को साल/महीने के आधार पर ग्रुप करता है।

Aggregate Functions:

SUM(): कुल रकम जोड़ता है।

COUNT(DISTINCT): यूनीक ऑर्डर गिनता है।

EXTRACT(): तारीख से साल/महीना निकालता है।

❓ FAQs (Interview Q/A)
महीने के हिसाब से डेटा कैसे ग्रुप करें?
→ EXTRACT(MONTH FROM order_date) + GROUP BY का उपयोग करें।

रेवेन्यू कैलकुलेट करने का तरीका?
→ SUM(amount) को ग्रुप बाय के साथ इस्तेमाल करें।

COUNT(*) vs COUNT(order_id) में अंतर?
→ COUNT(*) सभी रो गिनता है, COUNT(order_id) NULL इग्नोर करता है।

