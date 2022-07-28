import { Column, Entity, PrimaryColumn, BaseEntity } from 'typeorm';

@Entity('login_management')
export class LoginManagementEntity extends BaseEntity {
    @PrimaryColumn({ length: 10 })
    user_id: string;

    @Column({ length: 500 })
    access_token?: string;

    @Column({ length: 500 })
    device_token?: string;

    @Column()
    device_type?: number;

    @Column()
    expired_date?: Date;

    @Column({ length: 10 })
    created_by?: string;

    @Column({ length: 10 })
    updated_by?: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
