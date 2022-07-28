import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { EventEntity } from '../models/event.entity';
import { Event } from '../models/event.interface';

@Injectable()
export class EventService {
    constructor(
        @InjectRepository(EventEntity)
        private readonly eventRepository: Repository<EventEntity>
    ) {}

    createEvent(event: Event) {
        return this.eventRepository.save(event);
    }
}
