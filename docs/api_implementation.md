- /api/admin/dashboard

response:
{
    "success": true,
    "data": {
        "business": {
            "id": 1,
            "organization_id": 1,
            "name": "Witte Dental Chain",
            "slug": "witte-dental-chain",
            "business_type": "multi_hospital",
            "owner_name": "Super Admin",
            "owner_email": "superadmin@witte.com",
            "owner_phone": "9876543210",
            "address": {
                "street": "123 Main Street",
                "city": "Salem",
                "state": "Tamil Nadu",
                "pincode": "636001",
                "country": "India"
            },
            "tax_details": null,
            "status": "active",
            "trial_ends_at": null,
            "created_at": "2026-01-31T12:55:33.000000Z",
            "updated_at": "2026-01-31T12:55:33.000000Z",
            "deleted_at": null,
            "hospitals": [
                {
                    "id": 1,
                    "business_id": 1,
                    "name": "Witte Dental Main Branch",
                    "code": "WDM001",
                    "address": {
                        "street": "123 Main Street",
                        "city": "Salem",
                        "state": "Tamil Nadu",
                        "pincode": "636001",
                        "country": "India"
                    },
                    "phone": "0427-2345678",
                    "email": "main@witte.com",
                    "license_number": "DL-TN-001",
                    "is_main": true,
                    "status": "active",
                    "settings": null,
                    "payment_settings": null,
                    "whatsapp_settings": null,
                    "notification_settings": null,
                    "created_at": "2026-01-31T12:55:33.000000Z",
                    "updated_at": "2026-01-31T12:55:33.000000Z",
                    "deleted_at": null
                },
                {
                    "id": 2,
                    "business_id": 1,
                    "name": "Witte Dental Branch 2",
                    "code": "WDB002",
                    "address": {
                        "street": "456 Second Street",
                        "city": "Coimbatore",
                        "state": "Tamil Nadu",
                        "pincode": "641001",
                        "country": "India"
                    },
                    "phone": "0422-2345678",
                    "email": "branch2@witte.com",
                    "license_number": "DL-TN-002",
                    "is_main": false,
                    "status": "active",
                    "settings": null,
                    "payment_settings": null,
                    "whatsapp_settings": null,
                    "notification_settings": null,
                    "created_at": "2026-01-31T12:55:33.000000Z",
                    "updated_at": "2026-01-31T12:55:33.000000Z",
                    "deleted_at": null
                }
            ],
            "subscription": {
                "id": 1,
                "business_id": 1,
                "plan_id": 6,
                "razorpay_subscription_id": null,
                "status": "active",
                "current_period_start": "2026-01-31T12:55:34.000000Z",
                "current_period_end": "2027-01-31T12:55:34.000000Z",
                "trial_ends_at": null,
                "canceled_at": null,
                "created_at": "2026-01-31T12:55:34.000000Z",
                "updated_at": "2026-01-31T12:55:34.000000Z",
                "plan": {
                    "id": 6,
                    "name": "Enterprise Plan (Yearly)",
                    "slug": "enterprise-yearly",
                    "description": "Enterprise plan with 2 months free - billed annually",
                    "price": "199990.00",
                    "billing_cycle": "yearly",
                    "features": [
                        "patient_management",
                        "appointment_scheduling",
                        "advanced_reports",
                        "inventory_tracking",
                        "prescription_management",
                        "financial_analytics",
                        "staff_management",
                        "multi_location_support",
                        "api_access",
                        "priority_support",
                        "custom_integrations",
                        "white_label_options",
                        "advanced_security"
                    ],
                    "limits": {
                        "patients": -1,
                        "staff": -1,
                        "hospitals": -1,
                        "storage_gb": 100,
                        "appointments_per_month": -1
                    },
                    "razorpay_plan_id": null,
                    "is_active": true,
                    "created_at": "2026-01-26T10:40:58.000000Z",
                    "updated_at": "2026-01-26T10:40:58.000000Z"
                }
            }
        },
        "stats": {
            "total_hospitals": 2,
            "total_patients": 2,
            "total_staff": 4,
            "appointments_today": 0
        },
        "hospitals": [
            {
                "id": 1,
                "business_id": 1,
                "name": "Witte Dental Main Branch",
                "code": "WDM001",
                "address": {
                    "street": "123 Main Street",
                    "city": "Salem",
                    "state": "Tamil Nadu",
                    "pincode": "636001",
                    "country": "India"
                },
                "phone": "0427-2345678",
                "email": "main@witte.com",
                "license_number": "DL-TN-001",
                "is_main": true,
                "status": "active",
                "settings": null,
                "payment_settings": null,
                "whatsapp_settings": null,
                "notification_settings": null,
                "created_at": "2026-01-31T12:55:33.000000Z",
                "updated_at": "2026-01-31T12:55:33.000000Z",
                "deleted_at": null
            },
            {
                "id": 2,
                "business_id": 1,
                "name": "Witte Dental Branch 2",
                "code": "WDB002",
                "address": {
                    "street": "456 Second Street",
                    "city": "Coimbatore",
                    "state": "Tamil Nadu",
                    "pincode": "641001",
                    "country": "India"
                },
                "phone": "0422-2345678",
                "email": "branch2@witte.com",
                "license_number": "DL-TN-002",
                "is_main": false,
                "status": "active",
                "settings": null,
                "payment_settings": null,
                "whatsapp_settings": null,
                "notification_settings": null,
                "created_at": "2026-01-31T12:55:33.000000Z",
                "updated_at": "2026-01-31T12:55:33.000000Z",
                "deleted_at": null
            }
        ]
    }
}


- /api/dashboard/home?hospital_id=1
response:

{
    "status": true,
    "message": "Dashboard data retrieved successfully",
    "data": {
        "hospital_id": "1",
        "stats": {
            "total_patients": 1,
            "today_appointments": 0,
            "monthly_revenue": 0,
            "monthly_appointments": 0,
            "active_staff": 0,
            "pending_appointments": 0,
            "completed_treatments": 0,
            "trends": {
                "patients": {
                    "value": 100,
                    "direction": "down"
                },
                "appointments": {
                    "value": 0,
                    "direction": "up"
                },
                "revenue": {
                    "value": 0,
                    "direction": "up"
                }
            }
        },
        "today_appointments": [],
        "upcoming_appointments": [],
        "recent_activities": [
            {
                "type": "patient_registration",
                "message": "New patient Patient One registered",
                "time": "1 day ago",
                "icon": "user-plus"
            }
        ],
        "calendar_data": {
            "current_month": "2026-02",
            "appointments_by_date": []
        },
        "revenue_chart": {
            "monthly_data": [
                {
                    "month": "Sep",
                    "revenue": 0,
                    "appointments": 0
                },
                {
                    "month": "Oct",
                    "revenue": 0,
                    "appointments": 0
                },
                {
                    "month": "Nov",
                    "revenue": 0,
                    "appointments": 0
                },
                {
                    "month": "Dec",
                    "revenue": 0,
                    "appointments": 0
                },
                {
                    "month": "Jan",
                    "revenue": 0,
                    "appointments": 0
                },
                {
                    "month": "Feb",
                    "revenue": 0,
                    "appointments": 0
                }
            ],
            "total_revenue": 0
        },
        "quick_stats": {
            "patient_demographics": {
                "gender_distribution": {
                    "male": {
                        "count": 1,
                        "percentage": 100
                    },
                    "female": {
                        "count": 0,
                        "percentage": 0
                    }
                }
            },
            "popular_treatments": []
        },
        "top_treatments": [],
        "doctor_performance": [],
        "patient_retention": {
            "new_patients_this_month": 0,
            "retention_rate": 75
        },
        "payment_stats": {
            "collected_this_month": 0,
            "pending_payments": 0,
            "collection_rate": 85
        },
        "peak_hours": [],
        "delay_stats": {
            "total_appointments": 0,
            "delayed_appointments": 0,
            "avg_delay_minutes": 0,
            "on_time_percentage": 100
        },
        "meta": {
            "last_updated": "2026-02-02T05:49:57.410293Z",
            "refresh_interval": 300,
            "timezone": "Asia/Kolkata"
        }
    }
}