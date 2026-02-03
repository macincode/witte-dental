# witte_dental_pms

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Clean Authentication Architecture:
1. Super Admin Login (/superadmin/login)
Who: Witte company employees managing the SaaS platform

Credentials: Email + Password

Access: Platform-wide management, no business context needed

2. Business Admin Login (/admin/login)
Who: Hospital/clinic owners and their business admins

Credentials: Email + Password

Access: Business management with X-Business-ID header required

Response: Business context with hospitals list

3. Unified Staff Login (/login)
Who: Doctors, Staff, Patients within hospitals

Credentials: Email + Password

Access: Hospital-scoped operations

Response: User type + hospital context




Looking at the user table structure, I can see the role mapping:

role_id = 1: Super Admin

role_id = 2: Admin (Business Admin)

role_id = 3: Doctor

role_id = 4: Staff

role_id = 5: Patient

Three Clean Login Endpoints:
/api/superadmin/login - Super Admin only

/api/admin/login - Business Admin (requires X-Business-ID for dashboard)

/api/login - Unified for Doctor/Staff/Patient (email-based)

// Business Admin
const adminResponse = await fetch('/api/admin/login', {
  body: JSON.stringify({ email: 'admin.main@witte.com', password: 'password' })
});

// Doctor/Staff/Patient  
const userResponse = await fetch('/api/login', {
  body: JSON.stringify({ email: 'doctor.main@witte.com', password: 'password' })
});
// Returns: user_type: 'doctor'|'staff'|'patient'

// Super Admin
const superResponse = await fetch('/api/superadmin/login', {
  body: JSON.stringify({ email: 'superadmin@witte.com', password: 'password' })
});


updated collection for authentication flow:
{
  "info": {
    "_postman_id": "761d91d7-58e7-460d-94e4-e5b8e377708b",
    "name": "Witte Dental PMS - Updated API Collection",
    "description": "Updated API collection with unified authentication system for Witte Dental Practice Management System",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
    "_exporter_id": "8648285"
  },
  "variable": [
    {
      "key": "base_url",
      "value": "http://127.0.0.1:8000",
      "type": "string"
    },
    {
      "key": "api_token",
      "value": "",
      "type": "string"
    },
    {
      "key": "business_id",
      "value": "1",
      "type": "string"
    }
  ],
  "auth": {
    "type": "bearer",
    "bearer": [
      {
        "key": "token",
        "value": "{{api_token}}",
        "type": "string"
      }
    ]
  },
  "item": [
    {
      "name": "🔐 Authentication System",
      "item": [
        {
          "name": "Super Admin Login",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "if (pm.response.code === 200) {",
                  "    const response = pm.response.json();",
                  "    if (response.success && response.token) {",
                  "        pm.collectionVariables.set('api_token', response.token);",
                  "    }",
                  "}"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"email\": \"superadmin@witte.com\",\n    \"password\": \"password\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/superadmin/login",
              "host": ["{{base_url}}"],
              "path": ["api", "superadmin", "login"]
            },
            "description": "Login for Witte company super admins who manage the entire SaaS platform"
          }
        },
        {
          "name": "Business Admin Login",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "if (pm.response.code === 200) {",
                  "    const response = pm.response.json();",
                  "    if (response.success && response.token) {",
                  "        pm.collectionVariables.set('api_token', response.token);",
                  "        if (response.current_business && response.current_business.id) {",
                  "            pm.collectionVariables.set('business_id', response.current_business.id);",
                  "        }",
                  "    }",
                  "}"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"email\": \"admin.main@witte.com\",\n    \"password\": \"password\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/admin/login",
              "host": ["{{base_url}}"],
              "path": ["api", "admin", "login"]
            },
            "description": "Login for business admins who manage hospitals/clinics"
          }
        },
        {
          "name": "Staff Login (Doctor/Staff/Patient)",
          "event": [
            {
              "listen": "test",
              "script": {
                "exec": [
                  "if (pm.response.code === 200) {",
                  "    const response = pm.response.json();",
                  "    if (response.status && response.token) {",
                  "        pm.collectionVariables.set('api_token', response.token);",
                  "    }",
                  "}"
                ],
                "type": "text/javascript"
              }
            }
          ],
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"email\": \"doctor.main@witte.com\",\n    \"password\": \"password\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/login",
              "host": ["{{base_url}}"],
              "path": ["api", "login"]
            },
            "description": "Unified login for Doctors (role_id=3), Staff (role_id=4), and Patients (role_id=5)"
          }
        },
        {
          "name": "Logout",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/logout",
              "host": ["{{base_url}}"],
              "path": ["api", "logout"]
            }
          }
        }
      ]
    },
    {
      "name": "📊 Dashboard System",
      "item": [
        {
          "name": "Super Admin Dashboard",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/superadmin/dashboard",
              "host": ["{{base_url}}"],
              "path": ["api", "superadmin", "dashboard"]
            },
            "description": "SaaS platform overview for super admins"
          }
        },
        {
          "name": "Business Admin Dashboard",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "X-Business-ID",
                "value": "{{business_id}}",
                "description": "Required for business admin dashboard"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/admin/dashboard",
              "host": ["{{base_url}}"],
              "path": ["api", "admin", "dashboard"]
            },
            "description": "Business-specific dashboard (requires X-Business-ID header)"
          }
        },
        {
          "name": "Hospital Dashboard",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/dashboard/home?hospital_id=1",
              "host": ["{{base_url}}"],
              "path": ["api", "dashboard", "home"],
              "query": [
                {
                  "key": "hospital_id",
                  "value": "1"
                }
              ]
            },
            "description": "Hospital-specific dashboard with real-time KPIs and delay statistics"
          }
        }
      ]
    },
    {
      "name": "🏥 Super Admin Management",
      "item": [
        {
          "name": "Get All Businesses",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/superadmin/businesses?status=active&search=",
              "host": ["{{base_url}}"],
              "path": ["api", "superadmin", "businesses"],
              "query": [
                {
                  "key": "status",
                  "value": "active",
                  "description": "Filter by status: active, trial, expired"
                },
                {
                  "key": "search",
                  "value": "",
                  "description": "Search by business name or email"
                }
              ]
            }
          }
        },
        {
          "name": "Update Business Status",
          "request": {
            "method": "PATCH",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"status\": \"suspended\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/superadmin/businesses/1/status",
              "host": ["{{base_url}}"],
              "path": ["api", "superadmin", "businesses", "1", "status"]
            }
          }
        },
        {
          "name": "Get Subscription Plans",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/superadmin/subscription-plans",
              "host": ["{{base_url}}"],
              "path": ["api", "superadmin", "subscription-plans"]
            }
          }
        }
      ]
    },
    {
      "name": "🏢 Business Admin Management",
      "item": [
        {
          "name": "Get Hospital Settings",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/hospital/settings?hospital_id=1",
              "host": ["{{base_url}}"],
              "path": ["api", "hospital", "settings"],
              "query": [
                {
                  "key": "hospital_id",
                  "value": "1"
                }
              ]
            }
          }
        },
        {
          "name": "Update Payment Settings",
          "request": {
            "method": "PUT",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"hospital_id\": 1,\n    \"provider\": \"razorpay\",\n    \"key_id\": \"rzp_test_key\",\n    \"key_secret\": \"rzp_test_secret\",\n    \"webhook_secret\": \"webhook_secret\",\n    \"is_active\": true\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/hospital/settings/payment",
              "host": ["{{base_url}}"],
              "path": ["api", "hospital", "settings", "payment"]
            }
          }
        },
        {
          "name": "Update WhatsApp Settings",
          "request": {
            "method": "PUT",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"hospital_id\": 1,\n    \"access_token\": \"whatsapp_access_token\",\n    \"phone_number_id\": \"phone_number_id\",\n    \"business_account_id\": \"business_account_id\",\n    \"language_code\": \"en\",\n    \"is_active\": true\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/hospital/settings/whatsapp",
              "host": ["{{base_url}}"],
              "path": ["api", "hospital", "settings", "whatsapp"]
            }
          }
        }
      ]
    },
    {
      "name": "⏰ Appointment Delay Management",
      "item": [
        {
          "name": "Get Delay Statistics",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/appointment-delays/stats?hospital_id=1&date=2026-01-27",
              "host": ["{{base_url}}"],
              "path": ["api", "appointment-delays", "stats"],
              "query": [
                {
                  "key": "hospital_id",
                  "value": "1"
                },
                {
                  "key": "date",
                  "value": "2026-01-27",
                  "description": "Optional: defaults to today"
                }
              ]
            }
          }
        },
        {
          "name": "Mark Appointment Started",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"appointment_id\": 1\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/appointment-delays/mark-started",
              "host": ["{{base_url}}"],
              "path": ["api", "appointment-delays", "mark-started"]
            }
          }
        },
        {
          "name": "Manual Delay Check",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/appointment-delays/check-delays",
              "host": ["{{base_url}}"],
              "path": ["api", "appointment-delays", "check-delays"]
            },
            "description": "Manually trigger delay check (for testing)"
          }
        }
      ]
    },
    {
      "name": "👨⚕️ Doctor Management",
      "item": [
        {
          "name": "Get Doctor List",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/doctor_list",
              "host": ["{{base_url}}"],
              "path": ["api", "doctor_list"]
            }
          }
        },
        {
          "name": "Add Doctor",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"first_name\": \"Dr. John\",\n    \"surname\": \"Doe\",\n    \"email\": \"doctor@example.com\",\n    \"phone\": \"9876543210\",\n    \"aadhar_number\": \"123456789012\",\n    \"department_id\": 1,\n    \"password\": \"doctor123\",\n    \"confirm_password\": \"doctor123\",\n    \"dob\": \"1985-01-15\",\n    \"age\": 38,\n    \"gender\": \"Male\",\n    \"address\": \"123 Medical Street\",\n    \"qualification\": \"BDS, MDS\",\n    \"specialist\": \"Orthodontist\",\n    \"hospital_id\": 1\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/store_doctor",
              "host": ["{{base_url}}"],
              "path": ["api", "store_doctor"]
            }
          }
        }
      ]
    },
    {
      "name": "👥 Patient Management",
      "item": [
        {
          "name": "Get Patient List",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/patient_list",
              "host": ["{{base_url}}"],
              "path": ["api", "patient_list"]
            }
          }
        },
        {
          "name": "Add Patient",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"first_name\": \"John\",\n    \"surname\": \"Patient\",\n    \"email\": \"patient@example.com\",\n    \"phone\": \"9876543219\",\n    \"dob\": \"1990-01-01\",\n    \"age\": 34,\n    \"gender\": \"Male\",\n    \"address\": \"Patient Address\",\n    \"hospital_id\": 1\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/store_patient",
              "host": ["{{base_url}}"],
              "path": ["api", "store_patient"]
            }
          }
        }
      ]
    },
    {
      "name": "📅 Appointment Management",
      "item": [
        {
          "name": "Get Appointment List",
          "request": {
            "method": "GET",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              }
            ],
            "url": {
              "raw": "{{base_url}}/api/appointment_list",
              "host": ["{{base_url}}"],
              "path": ["api", "appointment_list"]
            }
          }
        },
        {
          "name": "Create Appointment",
          "request": {
            "method": "POST",
            "header": [
              {
                "key": "Authorization",
                "value": "Bearer {{api_token}}"
              },
              {
                "key": "Content-Type",
                "value": "application/json"
              }
            ],
            "body": {
              "mode": "raw",
              "raw": "{\n    \"patient_id\": 8,\n    \"doctor_id\": 4,\n    \"treatment_id\": 1,\n    \"service_id\": 1,\n    \"appointment_date\": \"2026-01-28\",\n    \"appointment_time\": \"10:00\",\n    \"treatment_name\": \"Dental Checkup\"\n}"
            },
            "url": {
              "raw": "{{base_url}}/api/store_appointment",
              "host": ["{{base_url}}"],
              "path": ["api", "store_appointment"]
            }
          }
        }
      ]
    }
  ]
}