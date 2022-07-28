import { Column, Entity, PrimaryColumn, BaseEntity } from 'typeorm';

@Entity('prefectures')
export class PrefectureEntity extends BaseEntity {
    @PrimaryColumn({ length: 11, unique: true })
    prefecture_id: string;

    @Column({ length: 4 })
    prefecture_name?: string;

    @Column({ length: 10 })
    created_by?: string;

    @Column({ length: 10 })
    updated_by?: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
