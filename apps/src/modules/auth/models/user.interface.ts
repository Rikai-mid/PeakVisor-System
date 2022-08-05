export interface User {
    user_id: string;
    full_name?: string;
    wix_user_id: string;
    prefeature_id: string;
    created_by: string;
    updated_by: string;
    created_at: Date;
    updated_at: Date;
}

export interface Login {
    loginId: string,
    password: string,
    device_token: string,
    device_type: string
}