import {
    Column,
    Entity,
    PrimaryColumn,
    PrimaryGeneratedColumn,
    BaseEntity,
} from 'typeorm';

@Entity('users')
export class UserEntity extends BaseEntity {
    @PrimaryColumn()
    user_id: string;

    @Column()
    wix_user_id: string;

    @Column({ length: 15 })
    full_name?: string;

    @Column()
    prefeature_id: string;

    @Column({ length: 10 })
    created_by: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
