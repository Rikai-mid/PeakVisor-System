import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { EventController } from './controller/auth.controller';
import { EventEntity } from './models/event.entity';
import { PointEntity } from './models/point.entity';
import { StageEntity } from './models/stages.entity';
import { EventService } from './service/event.service';
import { ChallengeEntity } from './models/challenge.entity';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            EventEntity,
            PointEntity,
            StageEntity,
            ChallengeEntity
        ])
    ],
    providers: [EventService],
    controllers: [EventController]
})
export class EventModule {}
