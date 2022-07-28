import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserProgressHistory } from '../models/user-history.interface';
import { UserProgressHistoryEntity } from '../models/user-progress-history.entity';

@Injectable()
export class EventService {
    constructor(
        @InjectRepository(UserProgressHistoryEntity)
        private readonly userRepository: Repository<UserProgressHistoryEntity>
    ) {}

    createUserHistory(userProgressHistory: UserProgressHistory) {
        return this.userRepository.save(userProgressHistory);
    }
}
