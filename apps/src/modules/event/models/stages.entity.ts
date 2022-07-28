import { Column, Entity, PrimaryColumn, BaseEntity } from 'typeorm';

@Entity('stages')
export class StageEntity extends BaseEntity {
    @PrimaryColumn()
    stage_id: number;

    @Column({ length: 100 })
    stage_name: string;

    @Column({ length: 300 })
    stage_description: string;

    @Column()
    category_id: number;

    @Column({ length: 50 })
    category_name: string;

    @Column()
    event_id: number;

    @Column()
    video_url: string;

    @Column()
    song1_url: string;

    @Column()
    song2_url: string;

    @Column()
    song3_url: string;

    @Column()
    song4_url: string;

    @Column()
    song5_url: string;

    @Column({ length: 10 })
    created_by: string;

    @Column({ length: 10 })
    updated_by: string;

    @Column()
    created_at: Date;

    @Column()
    updated_at: Date;
}
