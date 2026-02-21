# N8N Workflow Setup Guide - Registration Form to Email

This guide explains how to set up the n8n workflow to capture registration form submissions and send emails.

## Workflow Overview

The workflow:
1. **Receives** form data via webhook from the registration page
2. **Sends confirmation email** to the registrant
3. **Sends notification email** to your internal team
4. **Returns success response** to the client

## Prerequisites

- N8N instance running (self-hosted or cloud)
- SendGrid account with API key
- Email addresses for notifications

## Step-by-Step Setup

### 1. Create the Webhook Node

1. In n8n, create a new workflow
2. Add a **Webhook** node
3. Set the following:
   - **Path**: `registration`
   - **HTTP Method**: POST
   - **Authentication**: None
4. Copy the webhook URL (you'll use this in the registration form)

### 2. Add SendGrid Email Node (Confirmation Email)

1. Add an **Email SendGrid** node
2. Connect it from the Webhook node
3. Configure credentials:
   - Create a new SendGrid credential
   - Add your SendGrid API key

4. Set up the confirmation email:
   - **From Email**: Your company email (e.g., noreply@1minutesales.com)
   - **To Email**: Use expression: `{{ $json.email }}`
   - **Subject**: `Welcome to 1 Minute Sales - Thank You for Registering`
   - **Content Type**: HTML
   - **HTML Body**: Paste the template below

**Confirmation Email HTML Template:**
```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background-color: #D3BC5F; color: #000; padding: 20px; border-radius: 5px 5px 0 0; }
        .content { background-color: #f4f4f4; padding: 20px; border-radius: 0 0 5px 5px; }
        .footer { margin-top: 20px; font-size: 12px; color: #666; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Thank You for Registering!</h2>
        </div>
        <div class="content">
            <p>Hi {{ $json.firstName }},</p>
            <p>Thank you for registering with 1 Minute Sales! We've received your information and are excited to learn more about your business.</p>
            
            <h3>Here's what we received:</h3>
            <ul>
                <li><strong>Company:</strong> {{ $json.company }}</li>
                <li><strong>Sales Team Size:</strong> {{ $json.salesTeamSize }}</li>
                <li><strong>Website:</strong> {{ $json.websiteUrl || 'Not provided' }}</li>
            </ul>
            
            <p>Our team will review your information and reach out within 24 hours to schedule a brief call to discuss how we can help improve your conversion rates.</p>
            
            <p>In the meantime, check out our blog for tips on sales optimization: <a href="https://www.1minutesales.com/blog/">1 Minute Sales Blog</a></p>
            
            <p>Best regards,<br>
            The 1 Minute Sales Team</p>
        </div>
        <div class="footer">
            <p>&copy; 2025 1 Minute Sales. All rights reserved.</p>
            <p>30 North Gould Street, Suite 5531 | Sheridan, WY 82801</p>
        </div>
    </div>
</body>
</html>
```

### 3. Add SendGrid Email Node (Internal Notification)

1. Add another **Email SendGrid** node
2. Connect it from the confirmation email node
3. Use the same SendGrid credentials

4. Set up the internal notification email:
   - **From Email**: Your company email
   - **To Email**: Your internal email (e.g., sales@1minutesales.com) - or use multiple emails: `{{ $json.internalEmailList }}` if you have an array
   - **Subject**: `New Registration: {{ $json.firstName }} {{ $json.lastName }} - {{ $json.company }}`
   - **Content Type**: HTML
   - **HTML Body**: Paste the template below

**Internal Notification Email HTML Template:**
```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background-color: #0B0F12; color: #D3BC5F; padding: 20px; border-radius: 5px 5px 0 0; }
        .content { background-color: #f4f4f4; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th { background-color: #D3BC5F; color: #000; padding: 10px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        .footer { margin-top: 20px; font-size: 12px; color: #666; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>New Lead Registration</h2>
        </div>
        <div class="content">
            <p><strong>New registration received at {{ $json.timestamp }}</strong></p>
            
            <table>
                <tr>
                    <th>Field</th>
                    <th>Value</th>
                </tr>
                <tr>
                    <td><strong>Name</strong></td>
                    <td>{{ $json.firstName }} {{ $json.lastName }}</td>
                </tr>
                <tr>
                    <td><strong>Email</strong></td>
                    <td><a href="mailto:{{ $json.email }}">{{ $json.email }}</a></td>
                </tr>
                <tr>
                    <td><strong>Phone</strong></td>
                    <td><a href="tel:{{ $json.phone }}">{{ $json.phone }}</a></td>
                </tr>
                <tr>
                    <td><strong>Company</strong></td>
                    <td>{{ $json.company }}</td>
                </tr>
                <tr>
                    <td><strong>Sales Team Size</strong></td>
                    <td>{{ $json.salesTeamSize }}</td>
                </tr>
                <tr>
                    <td><strong>Website</strong></td>
                    <td>{{ $json.websiteUrl ? '<a href=\"' + $json.websiteUrl + '\">' + $json.websiteUrl + '</a>' : 'Not provided' }}</td>
                </tr>
                <tr>
                    <td><strong>Facebook</strong></td>
                    <td>{{ $json.facebookUrl || 'Not provided' }}</td>
                </tr>
                <tr>
                    <td><strong>Instagram</strong></td>
                    <td>{{ $json.instagramUrl || 'Not provided' }}</td>
                </tr>
                <tr>
                    <td><strong>LinkedIn</strong></td>
                    <td>{{ $json.linkedinUrl || 'Not provided' }}</td>
                </tr>
                <tr>
                    <td><strong>Yelp</strong></td>
                    <td>{{ $json.yelpUrl || 'Not provided' }}</td>
                </tr>
                <tr>
                    <td><strong>Google Maps</strong></td>
                    <td>{{ $json.googleMapsUrl || 'Not provided' }}</td>
                </tr>
            </table>
            
            <p><strong>Action Required:</strong> Follow up with this lead within 24 hours.</p>
        </div>
        <div class="footer">
            <p>This is an automated notification from 1 Minute Sales lead management system.</p>
        </div>
    </div>
</body>
</html>
```

### 4. Add HTTP Response Node

1. Add an **HTTP Response** node
2. Connect it from the last email node
3. Set up the response:
   - **Status Code**: 200
   - **Response Body**: Use JSON expression:
   ```json
  {
    "success": true,
    "message": "Thank you for registering! We'll contact you soon."
  }
  ```

## Integration with Registration Form

### Update the Webhook URL in register.html

1. Get your webhook URL from the n8n webhook node (format: `https://your-n8n-instance.com/webhook/registration`)
2. Open `register.html`
3. Find the line: `const response = await fetch('YOUR_N8N_WEBHOOK_URL_HERE', {`
4. Replace `YOUR_N8N_WEBHOOK_URL_HERE` with your actual webhook URL

Example:
```javascript
const response = await fetch('https://my-n8n-instance.com/webhook/registration', {
```

### Enable CORS (if needed)

If you're getting CORS errors:
1. In n8n, go to Settings → Security
2. Add your domain to the CORS whitelist
3. Or configure it in the webhook node's Advanced settings

## Testing the Workflow

1. **Test the Webhook:**
   - Click "Test" on the webhook node
   - You should see a URL like `https://your-n8n-instance.com/webhook-test/...`
   - Use a tool like Postman to send a test POST request

2. **Test the Full Form:**
   - Go to `https://your-domain.com/register.html`
   - Fill out the form with test data
   - Submit and verify:
     - You receive the confirmation email
     - Your internal team receives the notification email
     - No browser console errors

3. **Check N8N Execution:**
   - In n8n, go to Executions
   - Look for successful/failed runs
   - Check logs for any errors

## Customization Options

### Optional: Store in Database
To also save registrations to a database (optional):
1. Add a database node (PostgreSQL, MongoDB, etc.) after the webhook
2. Store all form fields in a `registrations` table
3. Connect it in parallel with the email nodes

### Optional: Slack Notification
To also send Slack notifications:
1. Add a Slack node
2. Set channel and message format
3. Include registration details in the message

### Optional: Add to CRM
To add leads to your CRM (HubSpot, Salesforce, etc.):
1. Add a node for your CRM
2. Map form fields to CRM contact fields
3. Create a new contact with the registration data

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Webhook not triggering | Check webhook URL is correct in HTML, verify CORS settings |
| Emails not sending | Verify SendGrid API key, check email addresses, review SendGrid logs |
| CORS errors | Add domain to n8n CORS whitelist or use a proxy |
| Data not appearing | Check node expressions use correct field names (case-sensitive) |
| HTTP 500 error | Check n8n logs for detailed error messages |

## Next Steps

1. Test the workflow thoroughly with real data
2. Set up email templates in SendGrid for better branding
3. Consider adding lead scoring or CRM integration
4. Monitor webhook usage and email delivery
5. Set up analytics to track conversion rates

## Support

For issues with n8n, visit: https://docs.n8n.io/
For SendGrid support, visit: https://sendgrid.com/docs/
